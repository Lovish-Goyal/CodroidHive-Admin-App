import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/event_model/event_model.dart';
import '../../../providers/events_provider.dart';
import 'edit_details.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  late EventModel _event;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Event Information")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_event.image != null && _event.image!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _event.image!,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/default.jpg',
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              _event.eventName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(_event.description ?? 'No description provided.'),
            const SizedBox(height: 16),
            Text(
              'Posted on: ${_event.createdAt.toLocal().toIso8601String().split('T').first}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 100), // Space before bottom bar
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final updated = await Navigator.push<EventModel>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditEventScreen(
                          event: _event), // You create this screen
                    ),
                  );
                  if (updated != null) {
                    setState(() {
                      _event = updated;
                    });
                    ref.refresh(eventListProvider);
                  }
                },
                child: const Text('Update Event'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        'Delete Event',
                      ),
                      content: const Text(
                          'Are you sure you want to delete this event?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await ref
                        .read(eventRepositoryProvider)
                        .deleteEvent(_event.id);
                    ref.refresh(eventListProvider);
                    Navigator.pop(context); // Close detail screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Event deleted successfully')),
                    );
                  }
                },
                child: const Text(
                  'Delete Event',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
