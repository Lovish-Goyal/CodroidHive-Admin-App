import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jobs_model.freezed.dart';
part 'jobs_model.g.dart';

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
class JobModel with _$JobModel {
  factory JobModel({
    required String id,
    String? jobName,
    String? description,
    required String title,
    String? subtitle,
    String? image,
    String? company,
    String? location,
    String? employmentType,
    double? salaryMin,
    double? salaryMax,
    String? currency,
    List<String>? tags,
    String? qualifications,
    String? responsibilities,
    String? requirements,
    String? applicationUrl,
    @Default(false) bool isRemote,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  JobModel._() : super();

  Map<String, dynamic> toMap() {
    return {
      ...toJson(),
      'createdAt': const TimestampConverter().toJson(createdAt),
      'updatedAt': const TimestampConverter().toJson(updatedAt),
    };
  }
}
