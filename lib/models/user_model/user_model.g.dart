// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      username: json['username'] as String? ?? 'Guest',
      gender: json['gender'] as String? ?? 'Male',
      role: json['role'] as String,
      status: json['status'] as String,
      profileImage: json['profileImage'] as String?,
      address: json['address'] as String?,
      dateOfBirth: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['dateOfBirth'], const TimestampConverter().fromJson),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
      'gender': instance.gender,
      'role': instance.role,
      'status': instance.status,
      'profileImage': instance.profileImage,
      'address': instance.address,
      'dateOfBirth': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.dateOfBirth, const TimestampConverter().toJson),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
