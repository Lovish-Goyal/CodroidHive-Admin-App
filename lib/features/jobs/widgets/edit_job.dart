import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../../models/jobs_model/jobs_model.dart';
import '../../../providers/jobs_provider.dart';
import '../../../utils/image_handler.dart';

class EditJobScreen extends ConsumerStatefulWidget {
  final JobModel job;

  const EditJobScreen({super.key, required this.job});

  @override
  ConsumerState<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends ConsumerState<EditJobScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _subtitleController;
  late TextEditingController _companyController;
  late TextEditingController _locationController;
  late TextEditingController _employmentTypeController;
  late TextEditingController _salaryMinController;
  late TextEditingController _salaryMaxController;
  late TextEditingController _currencyController;
  late TextEditingController _tagsController;
  late TextEditingController _qualificationsController;
  late TextEditingController _responsibilitiesController;
  late TextEditingController _requirementsController;
  late TextEditingController _applicationUrlController;
  bool _isRemote = false;
  File? imgUrl;

  @override
  void initState() {
    super.initState();
    final job = widget.job;
    _titleController = TextEditingController(text: job.title);
    _descriptionController = TextEditingController(text: job.description);
    _subtitleController = TextEditingController(text: job.subtitle);
    _companyController = TextEditingController(text: job.company);
    _locationController = TextEditingController(text: job.location);
    _employmentTypeController = TextEditingController(text: job.employmentType);
    _salaryMinController =
        TextEditingController(text: job.salaryMin?.toString());
    _salaryMaxController =
        TextEditingController(text: job.salaryMax?.toString());
    _currencyController = TextEditingController(text: job.currency);
    _tagsController = TextEditingController(text: job.tags?.join(', '));
    _qualificationsController = TextEditingController(text: job.qualifications);
    _responsibilitiesController =
        TextEditingController(text: job.responsibilities);
    _requirementsController = TextEditingController(text: job.requirements);
    _applicationUrlController = TextEditingController(text: job.applicationUrl);
    _isRemote = job.isRemote;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _subtitleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _employmentTypeController.dispose();
    _salaryMinController.dispose();
    _salaryMaxController.dispose();
    _currencyController.dispose();
    _tagsController.dispose();
    _qualificationsController.dispose();
    _responsibilitiesController.dispose();
    _requirementsController.dispose();
    _applicationUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveJob() async {
    if (!_formKey.currentState!.validate()) return;
    String? uploadedImageUrl = widget.job.image;
    if (imgUrl != null) {
      uploadedImageUrl = await ImageHandler.uploadImage(imgUrl!, 'job');
    }

    final updatedJob = widget.job.copyWith(
      image: uploadedImageUrl,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      subtitle: _subtitleController.text.trim(),
      company: _companyController.text.trim(),
      location: _locationController.text.trim(),
      employmentType: _employmentTypeController.text.trim(),
      salaryMin: double.tryParse(_salaryMinController.text.trim()),
      salaryMax: double.tryParse(_salaryMaxController.text.trim()),
      currency: _currencyController.text.trim(),
      tags: _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList(),
      qualifications: _qualificationsController.text.trim(),
      responsibilities: _responsibilitiesController.text.trim(),
      requirements: _requirementsController.text.trim(),
      applicationUrl: _applicationUrlController.text.trim(),
      isRemote: _isRemote,
      updatedAt: DateTime.now(),
    );

    await ref.read(jobRepositoryProvider).updateJob(updatedJob);
    ref.invalidate(jobListProvider);
    Navigator.pop(context, updatedJob);
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

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Job')),
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
              _buildTextField('Job Title', _titleController,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Please enter a title'
                      : null),
              _buildTextField('Subtitle', _subtitleController),
              _buildTextField('Description', _descriptionController,
                  maxLines: 3),
              _buildTextField('Company', _companyController),
              _buildTextField('Location', _locationController),
              _buildTextField('Employment Type', _employmentTypeController),
              _buildTextField('Salary Min', _salaryMinController),
              _buildTextField('Salary Max', _salaryMaxController),
              _buildTextField('Currency', _currencyController),
              _buildTextField('Tags (comma separated)', _tagsController),
              _buildTextField('Qualifications', _qualificationsController,
                  maxLines: 2),
              _buildTextField('Responsibilities', _responsibilitiesController,
                  maxLines: 2),
              _buildTextField('Requirements', _requirementsController,
                  maxLines: 2),
              _buildTextField('Application URL', _applicationUrlController),
              SwitchListTile(
                title: const Text('Remote'),
                value: _isRemote,
                onChanged: (val) => setState(() => _isRemote = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveJob,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
