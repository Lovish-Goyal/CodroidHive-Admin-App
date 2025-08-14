import 'dart:io';

import 'package:admin_app/utils/image_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../models/event_model/event_model.dart';
import '../../../providers/events_provider.dart';

class EditEventScreen extends ConsumerStatefulWidget {
  final EventModel event;

  const EditEventScreen({super.key, required this.event});

  @override
  ConsumerState<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends ConsumerState<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _venueController;
  late TextEditingController _sponsorController;
  DateTime? _selectedDate;
  File? imgUrl;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.eventName);
    _descriptionController =
        TextEditingController(text: widget.event.description);
    _venueController = TextEditingController(text: widget.event.venue);
    _sponsorController = TextEditingController(text: widget.event.sponser);
    _selectedDate = widget.event.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _venueController.dispose();
    _sponsorController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
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

  Future<void> _saveEvent() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date')),
      );
      return;
    }

    String? uploadedImageUrl = widget.event.image;
    if (imgUrl != null) {
      uploadedImageUrl = await ImageHandler.uploadImage(imgUrl!, 'event');
    }

    final updatedEvent = widget.event.copyWith(
      eventName: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      image: uploadedImageUrl,
      venue: _venueController.text.trim(),
      sponser: _sponsorController.text.trim(),
      date: _selectedDate!,
      updatedAt: DateTime.now(),
    );

    await ref.read(eventRepositoryProvider).updateEvent(updatedEvent);
    ref.refresh(eventListProvider);

    Navigator.pop(context, updatedEvent);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : 'Select Date';

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
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
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Event Title'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (val) => val == null || val.isEmpty
                    ? 'Description is required'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _venueController,
                decoration: const InputDecoration(labelText: 'Venue'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Venue is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sponsorController,
                decoration: const InputDecoration(labelText: 'Sponsor'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Sponsor is required' : null,
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text('Event Date: $formattedDate'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickDate(context),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveEvent,
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
