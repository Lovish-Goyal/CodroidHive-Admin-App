import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../../models/news_model/news_model.dart';
import '../../../providers/news_provider.dart';
import '../../../utils/image_handler.dart';

class AddNewsScreen extends ConsumerStatefulWidget {
  const AddNewsScreen({super.key});

  @override
  ConsumerState<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends ConsumerState<AddNewsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _imgFile;
  DateTime? _publishedDate;

  void _handleImage() async {
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

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? uploadedImageUrl;
      if (_imgFile != null) {
        uploadedImageUrl = await ImageHandler.uploadImage(_imgFile!, 'news');
      }

      final newNews = NewsModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        image: uploadedImageUrl,
        createdAt: _publishedDate ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(newsRepositoryProvider).addNews(newNews);
      ref.invalidate(userNewsListProvider);

      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('News added successfully')));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagePreview = _imgFile != null
        ? Image.file(
            _imgFile!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          )
        : Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade300,
            ),
            child: const Icon(Icons.image, size: 80, color: Colors.grey),
          );

    return Scaffold(
      appBar: AppBar(title: const Text('Add News')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image picker
              GestureDetector(
                onTap: _handleImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imagePreview,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              _buildField(_titleController, 'Title', isRequired: true),
              // Description
              _buildField(
                _descriptionController,
                'Description',
                isRequired: true,
                maxLines: 5,
              ),
              const SizedBox(height: 16),

              // Published Date (using Column to avoid overflow)
              const Text(
                'Published Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _publishedDate != null
                          ? "${_publishedDate!.day}/${_publishedDate!.month}/${_publishedDate!.year}"
                          : 'Not set',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text('Select Date'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Submit button centered
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Add News'),
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label, {
    bool isRequired = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: isRequired
            ? (val) => val == null || val.trim().isEmpty ? 'Enter $label' : null
            : null,
      ),
    );
  }
}
