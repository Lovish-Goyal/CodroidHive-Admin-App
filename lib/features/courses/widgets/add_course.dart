import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../../models/course_model/course_model.dart';
import '../../../providers/courses_provider.dart';
import '../../../utils/image_handler.dart';

class AddCourseScreen extends ConsumerStatefulWidget {
  const AddCourseScreen({super.key});

  @override
  ConsumerState<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends ConsumerState<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructorController = TextEditingController();
  final _instructorImageController = TextEditingController();
  final _currencyController = TextEditingController();
  final _tagsController = TextEditingController();
  final _languageController = TextEditingController();
  final _levelController = TextEditingController();
  final _videoUrlController = TextEditingController();
  final _certificateUrlController = TextEditingController();

  double? _price;
  int? _durationHours;
  int? _totalModules;
  bool _isFree = false;
  File? imgUrl;

  void _handleImage(BuildContext context, WidgetRef ref) async {
    final pickedFile = await ImageHandler.pickImage();

    if (pickedFile != null) {
      setState(() {
        imgUrl = pickedFile;
      });
      Logger().i("Image uploaded is $pickedFile");
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final image = await ImageHandler.uploadImage(imgUrl!, 'event');
      final newCourse = CourseModel(
        id: const Uuid().v4(),
        image: image,
        title: _titleController.text.trim(),
        subtitle: _subtitleController.text.trim(),
        description: _descriptionController.text.trim(),
        instructor: _instructorController.text.trim(),
        instructorImage: _instructorImageController.text.trim(),
        price: _price,
        currency: _currencyController.text.trim(),
        durationHours: _durationHours,
        totalModules: _totalModules,
        tags: _tagsController.text
            .trim()
            .split(',')
            .map((e) => e.trim())
            .toList(),
        language: _languageController.text.trim(),
        level: _levelController.text.trim(),
        videoUrl: _videoUrlController.text.trim(),
        certificateUrl: _certificateUrlController.text.trim(),
        isFree: _isFree,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(courseRepositoryProvider).addCourse(newCourse);
      ref.invalidate(courseListProvider);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course added successfully')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _instructorController.dispose();
    _instructorImageController.dispose();
    _currencyController.dispose();
    _tagsController.dispose();
    _languageController.dispose();
    _levelController.dispose();
    _videoUrlController.dispose();
    _certificateUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Course'),
      ),
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
              _buildField(_titleController, 'Title', isRequired: true),
              _buildField(_subtitleController, 'Subtitle'),
              _buildField(_descriptionController, 'Description',
                  isRequired: true),
              _buildField(_instructorController, 'Instructor Name',
                  isRequired: true),
              _buildField(_instructorImageController, 'Instructor Image URL'),
              _buildField(_currencyController, 'Currency'),
              _buildNumberField(
                  'Price', (val) => _price = double.tryParse(val)),
              _buildNumberField('Duration (Hours)',
                  (val) => _durationHours = int.tryParse(val)),
              _buildNumberField(
                  'Total Modules', (val) => _totalModules = int.tryParse(val)),
              _buildField(_tagsController, 'Tags (comma-separated)'),
              _buildField(_languageController, 'Language'),
              _buildField(
                  _levelController, 'Level (Beginner, Intermediate, Advanced)'),
              _buildField(_videoUrlController, 'Video URL'),
              _buildField(_certificateUrlController, 'Certificate URL'),
              SwitchListTile(
                title: const Text('Is Free'),
                value: _isFree,
                onChanged: (val) => setState(() => _isFree = val),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check),
                label: const Text('Add Course'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label,
      {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: isRequired
            ? (val) => val == null || val.isEmpty ? 'Enter $label' : null
            : null,
      ),
    );
  }

  Widget _buildNumberField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
        onChanged: onChanged,
      ),
    );
  }
}
