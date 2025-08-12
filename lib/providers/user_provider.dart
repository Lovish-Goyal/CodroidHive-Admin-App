// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/user_model/user_model.dart';

// /// Firestore Service for user operations
// class UserService {
//   final _usersRef = FirebaseFirestore.instance.collection('users');

//   Future<void> addUser(UserModel user) async {
//     await _usersRef.doc(user.id).set(user.toMap());
//   }

//   Future<void> updateUser(UserModel user) async {
//     await _usersRef.doc(user.id).update(user.toMap());
//   }

//   Future<void> deleteUser(String id) async {
//     await _usersRef.doc(id).delete();
//   }

//   Future<UserModel?> getUserById(String id) async {
//     final doc = await _usersRef.doc(id).get();
//     if (doc.exists) {
//       return UserModel.fromJson(doc.data()!);
//     }
//     return null;
//   }

//   Future<List<UserModel>> getAllUsers() async {
//     final querySnapshot = await _usersRef.get();
//     return querySnapshot.docs
//         .map((doc) => UserModel.fromJson(doc.data()))
//         .toList();
//   }
// }

// /// Provider for the UserService
// final userServiceProvider = Provider<UserService>((ref) => UserService());

// /// StateNotifier to manage a single user OR list of users (based on use case)
// class UserNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
//   final Ref ref;

//   UserNotifier(this.ref) : super(const AsyncValue.loading());

//   /// Fetch all users
//   Future<void> fetchAllUsers() async {
//     state = const AsyncValue.loading();
//     try {
//       final users = await ref.read(userServiceProvider).getAllUsers();
//       state = AsyncValue.data(users);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }

//   /// Add user and refresh list
//   Future<void> addUser(UserModel user) async {
//     try {
//       await ref.read(userServiceProvider).addUser(user);
//       await fetchAllUsers();
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }

//   /// Update user and refresh list
//   Future<void> updateUser(UserModel user) async {
//     try {
//       await ref.read(userServiceProvider).updateUser(user);
//       await fetchAllUsers();
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }

//   /// Delete user and refresh list
//   Future<void> deleteUser(String id) async {
//     try {
//       await ref.read(userServiceProvider).deleteUser(id);
//       await fetchAllUsers();
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }
// }

// /// StateNotifierProvider for user list
// final userProvider =
//     StateNotifierProvider<UserNotifier, AsyncValue<List<UserModel>>>(
//   (ref) => UserNotifier(ref),
// );

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model/user_model.dart';

class UserService {
  final _usersRef = FirebaseFirestore.instance.collection('users');

  Future<void> updateUser(UserModel user) async {
    await _usersRef.doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _usersRef.doc(id).delete();
  }

  Future<List<UserModel>> getUsersByStatus(String status) async {
    final querySnapshot =
        await _usersRef.where('status', isEqualTo: status).get();
    return querySnapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }
}

final userServiceProvider = Provider<UserService>((ref) => UserService());

class UserNotifier
    extends StateNotifier<AsyncValue<Map<String, List<UserModel>>>> {
  final Ref ref;

  UserNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    state = const AsyncValue.loading();
    try {
      final approved =
          await ref.read(userServiceProvider).getUsersByStatus('approved');
      final pending =
          await ref.read(userServiceProvider).getUsersByStatus('pending');
      state = AsyncValue.data({'approved': approved, 'pending': pending});
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> approveUser(UserModel user) async {
    final approvedUser =
        user.copyWith(status: 'approved', updatedAt: DateTime.now());
    await ref.read(userServiceProvider).updateUser(approvedUser);
    await fetchUsers();
  }

  Future<void> deleteUser(String id) async {
    await ref.read(userServiceProvider).deleteUser(id);
    await fetchUsers();
  }
}

final userProvider = StateNotifierProvider<UserNotifier,
    AsyncValue<Map<String, List<UserModel>>>>(
  (ref) => UserNotifier(ref),
);
