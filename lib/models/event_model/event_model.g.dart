// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      id: json['id'] as String,
      eventName: json['eventName'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      durationHours: (json['durationHours'] as num?)?.toInt(),
      venue: json['venue'] as String,
      sponser: json['sponser'] as String,
      isFree: json['isFree'] as bool? ?? false,
      date: const TimestampConverter().fromJson(json['date'] as Timestamp),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventName': instance.eventName,
      'description': instance.description,
      'image': instance.image,
      'durationHours': instance.durationHours,
      'venue': instance.venue,
      'sponser': instance.sponser,
      'isFree': instance.isFree,
      'date': const TimestampConverter().toJson(instance.date),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
