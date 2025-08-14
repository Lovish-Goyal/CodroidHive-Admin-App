import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../../models/jobs_model/jobs_model.dart';
import '../../../providers/jobs_provider.dart';
import '../../../utils/image_handler.dart';

class AddJobScreen extends ConsumerStatefulWidget {
  const AddJobScreen({super.key});

  @override
  ConsumerState<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends ConsumerState<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _jobNameController = TextEditingController();
  final _companyController = TextEditingController();
  final _locationController = TextEditingController();
  final _employmentTypeController = TextEditingController();
  final _salaryMinController = TextEditingController();
  final _salaryMaxController = TextEditingController();
  final _currencyController = TextEditingController();
  final _tagsController = TextEditingController();
  final _qualificationsController = TextEditingController();
  final _responsibilitiesController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _applicationUrlController = TextEditingController();
  bool _isRemote = false;
  File? imgUrl;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _subtitleController.dispose();
    _jobNameController.dispose();
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

  void _handleImage(BuildContext context, WidgetRef ref) async {
    final pickedFile = await ImageHandler.pickImage();

    if (pickedFile != null) {
      setState(() {
        imgUrl = pickedFile;
      });
      Logger().i("Image uploaded is $pickedFile");
    }
  }

  Future<void> _addJob() async {
    if (_formKey.currentState?.validate() ?? false) {
      final image = await ImageHandler.uploadImage(imgUrl!, 'job');
      final job = JobModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        jobName: _jobNameController.text.trim(),
        subtitle: _subtitleController.text.trim(),
        image: image,
        company: _companyController.text.trim(),
        location: _locationController.text.trim(),
        employmentType: _employmentTypeController.text.trim(),
        salaryMin: double.tryParse(_salaryMinController.text),
        salaryMax: double.tryParse(_salaryMaxController.text),
        currency: _currencyController.text.trim(),
        tags: _tagsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        qualifications: _qualificationsController.text.trim(),
        responsibilities: _responsibilitiesController.text.trim(),
        requirements: _requirementsController.text.trim(),
        applicationUrl: _applicationUrlController.text.trim(),
        isRemote: _isRemote,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(jobRepositoryProvider).addJob(job);
      ref.refresh(jobListProvider);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job added successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Job')),
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
              _buildTextField(_descriptionController, 'Description',
                  required: true),
              _buildTextField(_jobNameController, 'Job Name'),
              _buildTextField(_subtitleController, 'Subtitle'),
              _buildTextField(_companyController, 'Company'),
              _buildTextField(_locationController, 'Location'),
              _buildTextField(_employmentTypeController, 'Employment Type'),
              _buildTextField(_salaryMinController, 'Min Salary (e.g. 50000)'),
              _buildTextField(_salaryMaxController, 'Max Salary (e.g. 90000)'),
              _buildTextField(_currencyController, 'Currency (e.g. USD)'),
              _buildTextField(_tagsController, 'Tags (comma separated)'),
              _buildTextField(_qualificationsController, 'Qualifications'),
              _buildTextField(_responsibilitiesController, 'Responsibilities'),
              _buildTextField(_requirementsController, 'Requirements'),
              _buildTextField(_applicationUrlController, 'Application URL'),
              CheckboxListTile(
                value: _isRemote,
                onChanged: (val) => setState(() => _isRemote = val ?? false),
                title: const Text('Is Remote'),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _addJob,
                icon: const Icon(Icons.check),
                label: const Text('Add Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: required
            ? (val) => val == null || val.trim().isEmpty ? 'Required' : null
            : null,
      ),
    );
  }
}
