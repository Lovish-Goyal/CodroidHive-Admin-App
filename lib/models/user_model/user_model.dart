import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Custom converter for handling Firestore Timestamp
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) {
    return Timestamp.fromDate(date);
  }
}

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    String? email,
    String? phoneNumber,
    @Default('Guest') String username,
    @Default('Male') String gender,
    required String role,
    required String status,
    String? profileImage,
    String? address,
    @TimestampConverter() DateTime? dateOfBirth,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel._() : super();

  Map<String, dynamic> toMap() {
    return {
      ...toJson(),
      'createdAt': const TimestampConverter().toJson(createdAt),
      'updatedAt': const TimestampConverter().toJson(updatedAt),
    };
  }
}
