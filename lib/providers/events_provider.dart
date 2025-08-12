import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/event_model/event_model.dart';
import 'firestore_provider.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository(ref.read(firestoreProvider));
});

class EventRepository {
  final FirebaseFirestore firestore;
  EventRepository(this.firestore);

  CollectionReference get _collection => firestore.collection('events');

  Future<List<EventModel>> fetchEvents() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => EventModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<EventModel?> getEventById(String id) async {
    final doc = await _collection.doc(id).get();
    if (!doc.exists) return null;
    return EventModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<void> addEvent(EventModel event) async {
    await _collection.doc(event.id).set(event.toMap());
  }

  Future<void> updateEvent(EventModel event) async {
    await _collection.doc(event.id).update(event.toMap());
  }

  Future<void> deleteEvent(String id) async {
    await _collection.doc(id).delete();
  }
}

final eventListProvider = FutureProvider<List<EventModel>>((ref) {
  return ref.watch(eventRepositoryProvider).fetchEvents();
});
