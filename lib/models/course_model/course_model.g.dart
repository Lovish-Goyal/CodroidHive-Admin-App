// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseModelImpl _$$CourseModelImplFromJson(Map<String, dynamic> json) =>
    _$CourseModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String,
      image: json['image'] as String?,
      instructor: json['instructor'] as String,
      instructorImage: json['instructorImage'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      durationHours: (json['durationHours'] as num?)?.toInt(),
      totalModules: (json['totalModules'] as num?)?.toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      language: json['language'] as String?,
      level: json['level'] as String?,
      videoUrl: json['videoUrl'] as String?,
      certificateUrl: json['certificateUrl'] as String?,
      isFree: json['isFree'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      updatedAt: const TimestampConverter().fromJson(
        json['updatedAt'] as Timestamp,
      ),
    );

Map<String, dynamic> _$$CourseModelImplToJson(_$CourseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'image': instance.image,
      'instructor': instance.instructor,
      'instructorImage': instance.instructorImage,
      'price': instance.price,
      'currency': instance.currency,
      'durationHours': instance.durationHours,
      'totalModules': instance.totalModules,
      'tags': instance.tags,
      'language': instance.language,
      'level': instance.level,
      'videoUrl': instance.videoUrl,
      'certificateUrl': instance.certificateUrl,
      'isFree': instance.isFree,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
