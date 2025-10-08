import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../../models/news_model/news_model.dart';
import '../../../providers/news_provider.dart';
import '../../../utils/image_handler.dart';

class EditNewsScreen extends ConsumerStatefulWidget {
  final NewsModel news;

  const EditNewsScreen({super.key, required this.news});

  @override
  _EditNewsScreenState createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends ConsumerState<EditNewsScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _authorController;
  late TextEditingController _sourceController;

  File? _imgFile;
  DateTime? _publishedDate;

  @override
  void initState() {
    super.initState();
    final news = widget.news;
    _titleController = TextEditingController(text: news.title);
    _descriptionController = TextEditingController(text: news.description);
    _publishedDate = news.createdAt;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _authorController.dispose();
    _sourceController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final pickedFile = await ImageHandler.pickImage();
    if (pickedFile != null) {
      setState(() {
        _imgFile = pickedFile;
      });
      Logger().i("Image selected: $pickedFile");
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _publishedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _publishedDate = picked;
      });
    }
  }

  Future<void> _updateNews() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? uploadedImageUrl = widget.news.image;
      if (_imgFile != null) {
        uploadedImageUrl = await ImageHandler.uploadImage(_imgFile!, 'news');
      }

      final updatedNews = widget.news.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        image: uploadedImageUrl,
        createdAt: _publishedDate ?? widget.news.createdAt,
        updatedAt: DateTime.now(),
      );

      await ref.read(newsRepositoryProvider).updateNews(updatedNews);
      ref.invalidate(userNewsListProvider);

      Navigator.pop(context, updatedNews);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('News updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePreview = _imgFile != null
        ? Image.file(_imgFile!, width: 100, height: 100, fit: BoxFit.cover)
        : (widget.news.image != null
              ? Image.network(
                  widget.news.image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              : const SizedBox(
                  width: 100,
                  height: 100,
                  child: Icon(Icons.image),
                ));

    return Scaffold(
      appBar: AppBar(title: const Text('Edit News')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: _pickImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imagePreview,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildTextField(_titleController, 'Title', required: true),
              _buildTextField(
                _descriptionController,
                'Description',
                required: true,
                maxLines: 5,
              ),
              _buildTextField(_authorController, 'Author'),
              _buildTextField(_sourceController, 'Source'),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Published Date: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    _publishedDate != null
                        ? "${_publishedDate!.day}/${_publishedDate!.month}/${_publishedDate!.year}"
                        : 'Not set',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Update News'),
                onPressed: _updateNews,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label),
        validator: (val) {
          if (required && (val == null || val.trim().isEmpty)) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
