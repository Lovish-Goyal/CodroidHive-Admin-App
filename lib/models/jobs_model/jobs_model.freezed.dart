// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobs_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JobModel _$JobModelFromJson(Map<String, dynamic> json) {
  return _JobModel.fromJson(json);
}

/// @nodoc
mixin _$JobModel {
  String get id => throw _privateConstructorUsedError;
  String? get jobName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get employmentType => throw _privateConstructorUsedError;
  double? get salaryMin => throw _privateConstructorUsedError;
  double? get salaryMax => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get qualifications => throw _privateConstructorUsedError;
  String? get responsibilities => throw _privateConstructorUsedError;
  String? get requirements => throw _privateConstructorUsedError;
  String? get applicationUrl => throw _privateConstructorUsedError;
  bool get isRemote => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this JobModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JobModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JobModelCopyWith<JobModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobModelCopyWith<$Res> {
  factory $JobModelCopyWith(JobModel value, $Res Function(JobModel) then) =
      _$JobModelCopyWithImpl<$Res, JobModel>;
  @useResult
  $Res call(
      {String id,
      String? jobName,
      String? description,
      String title,
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
      bool isRemote,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}

/// @nodoc
class _$JobModelCopyWithImpl<$Res, $Val extends JobModel>
    implements $JobModelCopyWith<$Res> {
  _$JobModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JobModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobName = freezed,
    Object? description = freezed,
    Object? title = null,
    Object? subtitle = freezed,
    Object? image = freezed,
    Object? company = freezed,
    Object? location = freezed,
    Object? employmentType = freezed,
    Object? salaryMin = freezed,
    Object? salaryMax = freezed,
    Object? currency = freezed,
    Object? tags = freezed,
    Object? qualifications = freezed,
    Object? responsibilities = freezed,
    Object? requirements = freezed,
    Object? applicationUrl = freezed,
    Object? isRemote = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jobName: freezed == jobName
          ? _value.jobName
          : jobName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      employmentType: freezed == employmentType
          ? _value.employmentType
          : employmentType // ignore: cast_nullable_to_non_nullable
              as String?,
      salaryMin: freezed == salaryMin
          ? _value.salaryMin
          : salaryMin // ignore: cast_nullable_to_non_nullable
              as double?,
      salaryMax: freezed == salaryMax
          ? _value.salaryMax
          : salaryMax // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      qualifications: freezed == qualifications
          ? _value.qualifications
          : qualifications // ignore: cast_nullable_to_non_nullable
              as String?,
      responsibilities: freezed == responsibilities
          ? _value.responsibilities
          : responsibilities // ignore: cast_nullable_to_non_nullable
              as String?,
      requirements: freezed == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationUrl: freezed == applicationUrl
          ? _value.applicationUrl
          : applicationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isRemote: null == isRemote
          ? _value.isRemote
          : isRemote // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobModelImplCopyWith<$Res>
    implements $JobModelCopyWith<$Res> {
  factory _$$JobModelImplCopyWith(
          _$JobModelImpl value, $Res Function(_$JobModelImpl) then) =
      __$$JobModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? jobName,
      String? description,
      String title,
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
      bool isRemote,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}

/// @nodoc
class __$$JobModelImplCopyWithImpl<$Res>
    extends _$JobModelCopyWithImpl<$Res, _$JobModelImpl>
    implements _$$JobModelImplCopyWith<$Res> {
  __$$JobModelImplCopyWithImpl(
      _$JobModelImpl _value, $Res Function(_$JobModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of JobModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobName = freezed,
    Object? description = freezed,
    Object? title = null,
    Object? subtitle = freezed,
    Object? image = freezed,
    Object? company = freezed,
    Object? location = freezed,
    Object? employmentType = freezed,
    Object? salaryMin = freezed,
    Object? salaryMax = freezed,
    Object? currency = freezed,
    Object? tags = freezed,
    Object? qualifications = freezed,
    Object? responsibilities = freezed,
    Object? requirements = freezed,
    Object? applicationUrl = freezed,
    Object? isRemote = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$JobModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jobName: freezed == jobName
          ? _value.jobName
          : jobName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      employmentType: freezed == employmentType
          ? _value.employmentType
          : employmentType // ignore: cast_nullable_to_non_nullable
              as String?,
      salaryMin: freezed == salaryMin
          ? _value.salaryMin
          : salaryMin // ignore: cast_nullable_to_non_nullable
              as double?,
      salaryMax: freezed == salaryMax
          ? _value.salaryMax
          : salaryMax // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      qualifications: freezed == qualifications
          ? _value.qualifications
          : qualifications // ignore: cast_nullable_to_non_nullable
              as String?,
      responsibilities: freezed == responsibilities
          ? _value.responsibilities
          : responsibilities // ignore: cast_nullable_to_non_nullable
              as String?,
      requirements: freezed == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationUrl: freezed == applicationUrl
          ? _value.applicationUrl
          : applicationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isRemote: null == isRemote
          ? _value.isRemote
          : isRemote // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobModelImpl extends _JobModel {
  _$JobModelImpl(
      {required this.id,
      this.jobName,
      this.description,
      required this.title,
      this.subtitle,
      this.image,
      this.company,
      this.location,
      this.employmentType,
      this.salaryMin,
      this.salaryMax,
      this.currency,
      final List<String>? tags,
      this.qualifications,
      this.responsibilities,
      this.requirements,
      this.applicationUrl,
      this.isRemote = false,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.updatedAt})
      : _tags = tags,
        super._();

  factory _$JobModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? jobName;
  @override
  final String? description;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String? image;
  @override
  final String? company;
  @override
  final String? location;
  @override
  final String? employmentType;
  @override
  final double? salaryMin;
  @override
  final double? salaryMax;
  @override
  final String? currency;
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
  final String? qualifications;
  @override
  final String? responsibilities;
  @override
  final String? requirements;
  @override
  final String? applicationUrl;
  @override
  @JsonKey()
  final bool isRemote;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'JobModel(id: $id, jobName: $jobName, description: $description, title: $title, subtitle: $subtitle, image: $image, company: $company, location: $location, employmentType: $employmentType, salaryMin: $salaryMin, salaryMax: $salaryMax, currency: $currency, tags: $tags, qualifications: $qualifications, responsibilities: $responsibilities, requirements: $requirements, applicationUrl: $applicationUrl, isRemote: $isRemote, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jobName, jobName) || other.jobName == jobName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.employmentType, employmentType) ||
                other.employmentType == employmentType) &&
            (identical(other.salaryMin, salaryMin) ||
                other.salaryMin == salaryMin) &&
            (identical(other.salaryMax, salaryMax) ||
                other.salaryMax == salaryMax) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.qualifications, qualifications) ||
                other.qualifications == qualifications) &&
            (identical(other.responsibilities, responsibilities) ||
                other.responsibilities == responsibilities) &&
            (identical(other.requirements, requirements) ||
                other.requirements == requirements) &&
            (identical(other.applicationUrl, applicationUrl) ||
                other.applicationUrl == applicationUrl) &&
            (identical(other.isRemote, isRemote) ||
                other.isRemote == isRemote) &&
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
        jobName,
        description,
        title,
        subtitle,
        image,
        company,
        location,
        employmentType,
        salaryMin,
        salaryMax,
        currency,
        const DeepCollectionEquality().hash(_tags),
        qualifications,
        responsibilities,
        requirements,
        applicationUrl,
        isRemote,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of JobModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JobModelImplCopyWith<_$JobModelImpl> get copyWith =>
      __$$JobModelImplCopyWithImpl<_$JobModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobModelImplToJson(
      this,
    );
  }
}

abstract class _JobModel extends JobModel {
  factory _JobModel(
          {required final String id,
          final String? jobName,
          final String? description,
          required final String title,
          final String? subtitle,
          final String? image,
          final String? company,
          final String? location,
          final String? employmentType,
          final double? salaryMin,
          final double? salaryMax,
          final String? currency,
          final List<String>? tags,
          final String? qualifications,
          final String? responsibilities,
          final String? requirements,
          final String? applicationUrl,
          final bool isRemote,
          @TimestampConverter() required final DateTime createdAt,
          @TimestampConverter() required final DateTime updatedAt}) =
      _$JobModelImpl;
  _JobModel._() : super._();

  factory _JobModel.fromJson(Map<String, dynamic> json) =
      _$JobModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get jobName;
  @override
  String? get description;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  String? get image;
  @override
  String? get company;
  @override
  String? get location;
  @override
  String? get employmentType;
  @override
  double? get salaryMin;
  @override
  double? get salaryMax;
  @override
  String? get currency;
  @override
  List<String>? get tags;
  @override
  String? get qualifications;
  @override
  String? get responsibilities;
  @override
  String? get requirements;
  @override
  String? get applicationUrl;
  @override
  bool get isRemote;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of JobModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JobModelImplCopyWith<_$JobModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
