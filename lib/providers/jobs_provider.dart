import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../models/jobs_model/jobs_model.dart';
import 'firestore_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return JobRepository(firestore);
});

class JobRepository {
  final FirebaseFirestore firestore;
  JobRepository(this.firestore);

  CollectionReference get _collection => firestore.collection('jobs');

  Future<List<JobModel>> fetchJobs() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => JobModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<JobModel?> getJobById(String id) async {
    final doc = await _collection.doc(id).get();
    if (!doc.exists) return null;
    return JobModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<void> addJob(JobModel job) async {
    await _collection.doc(job.id).set(job.toMap());
  }

  Future<void> updateJob(JobModel job) async {
    await _collection.doc(job.id).update(job.toMap());
  }

  Future<void> deleteJob(String id) async {
    await _collection.doc(id).delete();
  }
}

final jobListProvider = FutureProvider<List<JobModel>>((ref) {
  return ref.watch(jobRepositoryProvider).fetchJobs();
});
