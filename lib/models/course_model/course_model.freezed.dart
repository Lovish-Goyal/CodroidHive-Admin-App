// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) {
  return _CourseModel.fromJson(json);
}

/// @nodoc
mixin _$CourseModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get instructor => throw _privateConstructorUsedError;
  String? get instructorImage => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  int? get durationHours => throw _privateConstructorUsedError;
  int? get totalModules => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  String? get certificateUrl => throw _privateConstructorUsedError;
  bool get isFree => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CourseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseModelCopyWith<CourseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseModelCopyWith<$Res> {
  factory $CourseModelCopyWith(
    CourseModel value,
    $Res Function(CourseModel) then,
  ) = _$CourseModelCopyWithImpl<$Res, CourseModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String? subtitle,
    String description,
    String? image,
    String instructor,
    String? instructorImage,
    double? price,
    String? currency,
    int? durationHours,
    int? totalModules,
    List<String>? tags,
    String? language,
    String? level,
    String? videoUrl,
    String? certificateUrl,
    bool isFree,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$CourseModelCopyWithImpl<$Res, $Val extends CourseModel>
    implements $CourseModelCopyWith<$Res> {
  _$CourseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? description = null,
    Object? image = freezed,
    Object? instructor = null,
    Object? instructorImage = freezed,
    Object? price = freezed,
    Object? currency = freezed,
    Object? durationHours = freezed,
    Object? totalModules = freezed,
    Object? tags = freezed,
    Object? language = freezed,
    Object? level = freezed,
    Object? videoUrl = freezed,
    Object? certificateUrl = freezed,
    Object? isFree = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: freezed == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            instructor: null == instructor
                ? _value.instructor
                : instructor // ignore: cast_nullable_to_non_nullable
                      as String,
            instructorImage: freezed == instructorImage
                ? _value.instructorImage
                : instructorImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationHours: freezed == durationHours
                ? _value.durationHours
                : durationHours // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalModules: freezed == totalModules
                ? _value.totalModules
                : totalModules // ignore: cast_nullable_to_non_nullable
                      as int?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            language: freezed == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String?,
            level: freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String?,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            certificateUrl: freezed == certificateUrl
                ? _value.certificateUrl
                : certificateUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isFree: null == isFree
                ? _value.isFree
                : isFree // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseModelImplCopyWith<$Res>
    implements $CourseModelCopyWith<$Res> {
  factory _$$CourseModelImplCopyWith(
    _$CourseModelImpl value,
    $Res Function(_$CourseModelImpl) then,
  ) = __$$CourseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? subtitle,
    String description,
    String? image,
    String instructor,
    String? instructorImage,
    double? price,
    String? currency,
    int? durationHours,
    int? totalModules,
    List<String>? tags,
    String? language,
    String? level,
    String? videoUrl,
    String? certificateUrl,
    bool isFree,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$CourseModelImplCopyWithImpl<$Res>
    extends _$CourseModelCopyWithImpl<$Res, _$CourseModelImpl>
    implements _$$CourseModelImplCopyWith<$Res> {
  __$$CourseModelImplCopyWithImpl(
    _$CourseModelImpl _value,
    $Res Function(_$CourseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? description = null,
    Object? image = freezed,
    Object? instructor = null,
    Object? instructorImage = freezed,
    Object? price = freezed,
    Object? currency = freezed,
    Object? durationHours = freezed,
    Object? totalModules = freezed,
    Object? tags = freezed,
    Object? language = freezed,
    Object? level = freezed,
    Object? videoUrl = freezed,
    Object? certificateUrl = freezed,
    Object? isFree = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CourseModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: freezed == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        instructor: null == instructor
            ? _value.instructor
            : instructor // ignore: cast_nullable_to_non_nullable
                  as String,
        instructorImage: freezed == instructorImage
            ? _value.instructorImage
            : instructorImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationHours: freezed == durationHours
            ? _value.durationHours
            : durationHours // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalModules: freezed == totalModules
            ? _value.totalModules
            : totalModules // ignore: cast_nullable_to_non_nullable
                  as int?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        language: freezed == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String?,
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String?,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        certificateUrl: freezed == certificateUrl
            ? _value.certificateUrl
            : certificateUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isFree: null == isFree
            ? _value.isFree
            : isFree // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseModelImpl extends _CourseModel {
  _$CourseModelImpl({
    required this.id,
    required this.title,
    this.subtitle,
    required this.description,
    this.image,
    required this.instructor,
    this.instructorImage,
    this.price,
    this.currency,
    this.durationHours,
    this.totalModules,
    final List<String>? tags,
    this.language,
    this.level,
    this.videoUrl,
    this.certificateUrl,
    this.isFree = false,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
  }) : _tags = tags,
       super._();

  factory _$CourseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String description;
  @override
  final String? image;
  @override
  final String instructor;
  @override
  final String? instructorImage;
  @override
  final double? price;
  @override
  final String? currency;
  @override
  final int? durationHours;
  @override
  final int? totalModules;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? language;
  @override
  final String? level;
  @override
  final String? videoUrl;
  @override
  final String? certificateUrl;
  @override
  @JsonKey()
  final bool isFree;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CourseModel(id: $id, title: $title, subtitle: $subtitle, description: $description, image: $image, instructor: $instructor, instructorImage: $instructorImage, price: $price, currency: $currency, durationHours: $durationHours, totalModules: $totalModules, tags: $tags, language: $language, level: $level, videoUrl: $videoUrl, certificateUrl: $certificateUrl, isFree: $isFree, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.instructor, instructor) ||
                other.instructor == instructor) &&
            (identical(other.instructorImage, instructorImage) ||
                other.instructorImage == instructorImage) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.durationHours, durationHours) ||
                other.durationHours == durationHours) &&
            (identical(other.totalModules, totalModules) ||
                other.totalModules == totalModules) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.certificateUrl, certificateUrl) ||
                other.certificateUrl == certificateUrl) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    subtitle,
    description,
    image,
    instructor,
    instructorImage,
    price,
    currency,
    durationHours,
    totalModules,
    const DeepCollectionEquality().hash(_tags),
    language,
    level,
    videoUrl,
    certificateUrl,
    isFree,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseModelImplCopyWith<_$CourseModelImpl> get copyWith =>
      __$$CourseModelImplCopyWithImpl<_$CourseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseModelImplToJson(this);
  }
}

abstract class _CourseModel extends CourseModel {
  factory _CourseModel({
    required final String id,
    required final String title,
    final String? subtitle,
    required final String description,
    final String? image,
    required final String instructor,
    final String? instructorImage,
    final double? price,
    final String? currency,
    final int? durationHours,
    final int? totalModules,
    final List<String>? tags,
    final String? language,
    final String? level,
    final String? videoUrl,
    final String? certificateUrl,
    final bool isFree,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$CourseModelImpl;
  _CourseModel._() : super._();

  factory _CourseModel.fromJson(Map<String, dynamic> json) =
      _$CourseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  String get description;
  @override
  String? get image;
  @override
  String get instructor;
  @override
  String? get instructorImage;
  @override
  double? get price;
  @override
  String? get currency;
  @override
  int? get durationHours;
  @override
  int? get totalModules;
  @override
  List<String>? get tags;
  @override
  String? get language;
  @override
  String? get level;
  @override
  String? get videoUrl;
  @override
  String? get certificateUrl;
  @override
  bool get isFree;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseModelImplCopyWith<_$CourseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
