// dashboard_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final dashboardProvider = FutureProvider<Map<String, int>>((ref) async {
  final firestore = FirebaseFirestore.instance;

  final usersCount =
      await firestore.collection('users').get().then((snap) => snap.size);
  final jobsCount =
      await firestore.collection('jobs').get().then((snap) => snap.size);
  final eventsCount =
      await firestore.collection('events').get().then((snap) => snap.size);
  final coursesCount =
      await firestore.collection('courses').get().then((snap) => snap.size);

  return {
    'users': usersCount,
    'jobs': jobsCount,
    'events': eventsCount,
    'courses': coursesCount,
  };
});
