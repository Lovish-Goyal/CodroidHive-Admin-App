import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/course_model/course_model.dart';
import 'firestore_provider.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository(ref.read(firestoreProvider));
});

class CourseRepository {
  final FirebaseFirestore firestore;
  CourseRepository(this.firestore);

  CollectionReference get _collection => firestore.collection('courses');

  Future<List<CourseModel>> fetchCourses() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => CourseModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<CourseModel?> getCourseById(String id) async {
    final doc = await _collection.doc(id).get();
    if (!doc.exists) return null;
    return CourseModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<void> addCourse(CourseModel course) async {
    await _collection.doc(course.id).set(course.toMap());
  }

  Future<void> updateCourse(CourseModel course) async {
    await _collection.doc(course.id).update(course.toMap());
  }

  Future<void> deleteCourse(String id) async {
    await _collection.doc(id).delete();
  }
}

final courseListProvider = FutureProvider<List<CourseModel>>((ref) {
  return ref.watch(courseRepositoryProvider).fetchCourses();
});
