// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobModelImpl _$$JobModelImplFromJson(Map<String, dynamic> json) =>
    _$JobModelImpl(
      id: json['id'] as String,
      jobName: json['jobName'] as String?,
      description: json['description'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      image: json['image'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      employmentType: json['employmentType'] as String?,
      salaryMin: (json['salaryMin'] as num?)?.toDouble(),
      salaryMax: (json['salaryMax'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      qualifications: json['qualifications'] as String?,
      responsibilities: json['responsibilities'] as String?,
      requirements: json['requirements'] as String?,
      applicationUrl: json['applicationUrl'] as String?,
      isRemote: json['isRemote'] as bool? ?? false,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$$JobModelImplToJson(_$JobModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobName': instance.jobName,
      'description': instance.description,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'image': instance.image,
      'company': instance.company,
      'location': instance.location,
      'employmentType': instance.employmentType,
      'salaryMin': instance.salaryMin,
      'salaryMax': instance.salaryMax,
      'currency': instance.currency,
      'tags': instance.tags,
      'qualifications': instance.qualifications,
      'responsibilities': instance.responsibilities,
      'requirements': instance.requirements,
      'applicationUrl': instance.applicationUrl,
      'isRemote': instance.isRemote,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
