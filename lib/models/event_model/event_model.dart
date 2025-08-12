import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

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
class EventModel with _$EventModel {
  factory EventModel({
    required String id,
    required String eventName,
    String? description,
    String? image,
    int? durationHours,
    required String venue,
    required String sponser,
    @Default(false) bool isFree,
    @TimestampConverter() required DateTime date,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  EventModel._() : super();

  Map<String, dynamic> toMap() {
    return {
      ...toJson(),
      'createdAt': const TimestampConverter().toJson(createdAt),
      'updatedAt': const TimestampConverter().toJson(updatedAt),
    };
  }
}
