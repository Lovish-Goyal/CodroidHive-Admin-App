import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

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
class NewsModel with _$NewsModel {
  factory NewsModel({
    required String id,
    String? title,
    String? description,
    String? image,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  NewsModel._() : super();

  Map<String, dynamic> toMap() {
    return {
      ...toJson(),
      'createdAt': const TimestampConverter().toJson(createdAt),
      'updatedAt': const TimestampConverter().toJson(updatedAt),
    };
  }
}
