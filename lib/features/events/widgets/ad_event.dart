import 'dart:io';

import 'package:admin_app/utils/image_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../../models/event_model/event_model.dart';
import '../../../providers/events_provider.dart';

class AddEventScreen extends ConsumerStatefulWidget {
  const AddEventScreen({super.key});

  @override
  ConsumerState<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends ConsumerState<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _venueController = TextEditingController();
  final _sponsorController = TextEditingController();

  DateTime? _selectedDate;
  File? imgUrl;

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
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

  Future<void> _addEvent() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date')),
        );
        return;
      }

      final image = await ImageHandler.uploadImage(imgUrl!, 'event');

      final event = EventModel(
        id: const Uuid().v4(),
        eventName: _titleController.text.trim(),
        description: _descController.text.trim(),
        image: image,
        venue: _venueController.text.trim(),
        sponser: _sponsorController.text.trim(),
        date: _selectedDate!,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(eventRepositoryProvider).addEvent(event);
      ref.refresh(eventListProvider);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event added successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : 'Select Date';

    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
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
                    val == null || val.isEmpty ? 'Enter event title' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _venueController,
                decoration: const InputDecoration(labelText: 'Venue'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter venue' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sponsorController,
                decoration: const InputDecoration(labelText: 'Sponsor'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter sponsor' : null,
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text('Event Date: $dateStr'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _addEvent,
                icon: const Icon(Icons.save),
                label: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
