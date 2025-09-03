import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../../models/course_model/course_model.dart';
import '../../../providers/courses_provider.dart';
import '../../../utils/image_handler.dart';

class EditCourseScreen extends ConsumerStatefulWidget {
  final CourseModel course;

  const EditCourseScreen({super.key, required this.course});

  @override
  _EditCourseScreenState createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends ConsumerState<EditCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _descriptionController;
  late TextEditingController _instructorController;
  late TextEditingController _instructorImageController;
  late TextEditingController _priceController;
  late TextEditingController _currencyController;
  late TextEditingController _durationController;
  late TextEditingController _modulesController;
  late TextEditingController _tagsController;
  late TextEditingController _languageController;
  late TextEditingController _levelController;
  late TextEditingController _videoUrlController;
  late TextEditingController _certificateUrlController;

  bool _isFree = false;
  File? imgUrl;

  @override
  void initState() {
    super.initState();
    final course = widget.course;
    _titleController = TextEditingController(text: course.title);
    _subtitleController = TextEditingController(text: course.subtitle ?? '');
    _descriptionController = TextEditingController(text: course.description);
    _instructorController = TextEditingController(text: course.instructor);
    _instructorImageController =
        TextEditingController(text: course.instructorImage ?? '');
    _priceController =
        TextEditingController(text: course.price?.toString() ?? '');
    _currencyController = TextEditingController(text: course.currency ?? 'USD');
    _durationController =
        TextEditingController(text: course.durationHours?.toString() ?? '');
    _modulesController =
        TextEditingController(text: course.totalModules?.toString() ?? '');
    _tagsController =
        TextEditingController(text: course.tags?.join(', ') ?? '');
    _languageController =
        TextEditingController(text: course.language ?? 'English');
    _levelController = TextEditingController(text: course.level ?? '');
    _videoUrlController = TextEditingController(text: course.videoUrl ?? '');
    _certificateUrlController =
        TextEditingController(text: course.certificateUrl ?? '');
    _isFree = course.isFree;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _instructorController.dispose();
    _instructorImageController.dispose();
    _priceController.dispose();
    _currencyController.dispose();
    _durationController.dispose();
    _modulesController.dispose();
    _tagsController.dispose();
    _languageController.dispose();
    _levelController.dispose();
    _videoUrlController.dispose();
    _certificateUrlController.dispose();
    super.dispose();
  }

  void _handleImage(BuildContext context, WidgetRef ref) async {
    final pickedFile = await ImageHandler.pickImage();

    if (pickedFile != null) {
      setState(() {
        imgUrl = pickedFile;
      });
      Logger().i("Image uploaded is $pickedFile");
    }
  }

  Future<void> _updateCourse() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? uploadedImageUrl = widget.course.image;
      if (imgUrl != null) {
        uploadedImageUrl = await ImageHandler.uploadImage(imgUrl!, 'event');
      }
      final updatedCourse = widget.course.copyWith(
        image: uploadedImageUrl,
        title: _titleController.text.trim(),
        subtitle: _subtitleController.text.trim(),
        description: _descriptionController.text.trim(),
        instructor: _instructorController.text.trim(),
        instructorImage: _instructorImageController.text.trim(),
        price: _priceController.text.isNotEmpty
            ? double.tryParse(_priceController.text.trim())
            : null,
        currency: _currencyController.text.trim(),
        durationHours: _durationController.text.isNotEmpty
            ? int.tryParse(_durationController.text.trim())
            : null,
        totalModules: _modulesController.text.isNotEmpty
            ? int.tryParse(_modulesController.text.trim())
            : null,
        tags: _tagsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        language: _languageController.text.trim(),
        level: _levelController.text.trim(),
        videoUrl: _videoUrlController.text.trim(),
        certificateUrl: _certificateUrlController.text.trim(),
        isFree: _isFree,
        updatedAt: DateTime.now(),
      );

      await ref.read(courseRepositoryProvider).updateCourse(updatedCourse);
      ref.invalidate(courseListProvider);

      Navigator.pop(context, updatedCourse);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50,
                  child: InkWell(
                    onTap: () => _handleImage(context, ref),
                    child: Icon(
                      Icons.camera_alt,
                    ),
                  ),
                ),
              ),
              _buildTextField(_titleController, 'Title', required: true),
              _buildTextField(_subtitleController, 'Subtitle'),
              _buildTextField(_descriptionController, 'Description',
                  required: true),
              _buildTextField(_instructorController, 'Instructor',
                  required: true),
              _buildTextField(
                  _instructorImageController, 'Instructor Image URL'),
              _buildTextField(_priceController, 'Price', isNumber: true),
              _buildTextField(_currencyController, 'Currency'),
              _buildTextField(_durationController, 'Duration Hours',
                  isNumber: true),
              _buildTextField(_modulesController, 'Total Modules',
                  isNumber: true),
              _buildTextField(_tagsController, 'Tags (comma-separated)'),
              _buildTextField(_languageController, 'Language'),
              _buildTextField(_levelController, 'Level'),
              _buildTextField(_videoUrlController, 'Video URL'),
              _buildTextField(_certificateUrlController, 'Certificate URL'),
              SwitchListTile(
                title: const Text('Is Free'),
                value: _isFree,
                onChanged: (val) => setState(() => _isFree = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Update Course'),
                onPressed: _updateCourse,
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
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
        validator: (val) {
          if (required && (val == null || val.trim().isEmpty)) {
            return 'Please enter $label';
          }
          if (isNumber && val != null && val.trim().isNotEmpty) {
            final number = double.tryParse(val.trim());
            if (number == null) return 'Enter a valid number for $label';
          }
          return null;
        },
      ),
    );
  }
}
