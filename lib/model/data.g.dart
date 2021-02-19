// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) {
  return ResponseData(
    code: json['code'] as int,
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    hijri: json['hijri'] == null
        ? null
        : Hijri.fromJson(json['hijri'] as Map<String, dynamic>),
    gregorian: json['gregorian'] == null
        ? null
        : Hijri.fromJson(json['gregorian'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'hijri': instance.hijri,
      'gregorian': instance.gregorian,
    };

Gregorian _$GregorianFromJson(Map<String, dynamic> json) {
  return Gregorian(
    date: json['date'] as String,
    format: json['format'] as String,
    day: json['day'] as String,
    weekday: json['weekday'] == null
        ? null
        : GregorianWeekday.fromJson(json['weekday'] as Map<String, dynamic>),
    month: json['month'] == null
        ? null
        : GregorianMonth.fromJson(json['month'] as Map<String, dynamic>),
    year: json['year'] as String,
    designation: json['designation'] == null
        ? null
        : Designation.fromJson(json['designation'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GregorianToJson(Gregorian instance) => <String, dynamic>{
      'date': instance.date,
      'format': instance.format,
      'day': instance.day,
      'weekday': instance.weekday,
      'month': instance.month,
      'year': instance.year,
      'designation': instance.designation,
    };

Designation _$DesignationFromJson(Map<String, dynamic> json) {
  return Designation(
    abbreviated: json['abbreviated'] as String,
    expanded: json['expanded'] as String,
  );
}

Map<String, dynamic> _$DesignationToJson(Designation instance) =>
    <String, dynamic>{
      'abbreviated': instance.abbreviated,
      'expanded': instance.expanded,
    };

GregorianMonth _$GregorianMonthFromJson(Map<String, dynamic> json) {
  return GregorianMonth(
    number: json['number'] as int,
    en: json['en'] as String,
  );
}

Map<String, dynamic> _$GregorianMonthToJson(GregorianMonth instance) =>
    <String, dynamic>{
      'number': instance.number,
      'en': instance.en,
    };

GregorianWeekday _$GregorianWeekdayFromJson(Map<String, dynamic> json) {
  return GregorianWeekday(
    en: json['en'] as String,
  );
}

Map<String, dynamic> _$GregorianWeekdayToJson(GregorianWeekday instance) =>
    <String, dynamic>{
      'en': instance.en,
    };

Hijri _$HijriFromJson(Map<String, dynamic> json) {
  return Hijri(
    date: json['date'] as String,
    format: json['format'] as String,
    day: json['day'] as String,
    weekday: json['weekday'] == null
        ? null
        : HijriWeekday.fromJson(json['weekday'] as Map<String, dynamic>),
    month: json['month'] == null
        ? null
        : HijriMonth.fromJson(json['month'] as Map<String, dynamic>),
    year: json['year'] as String,
    designation: json['designation'] == null
        ? null
        : Designation.fromJson(json['designation'] as Map<String, dynamic>),
    holidays: json['holidays'] as List,
  );
}

Map<String, dynamic> _$HijriToJson(Hijri instance) => <String, dynamic>{
      'date': instance.date,
      'format': instance.format,
      'day': instance.day,
      'weekday': instance.weekday,
      'month': instance.month,
      'year': instance.year,
      'designation': instance.designation,
      'holidays': instance.holidays,
    };

HijriMonth _$HijriMonthFromJson(Map<String, dynamic> json) {
  return HijriMonth(
    number: json['number'] as int,
    en: json['en'] as String,
    ar: json['ar'] as String,
  );
}

Map<String, dynamic> _$HijriMonthToJson(HijriMonth instance) =>
    <String, dynamic>{
      'number': instance.number,
      'en': instance.en,
      'ar': instance.ar,
    };

HijriWeekday _$HijriWeekdayFromJson(Map<String, dynamic> json) {
  return HijriWeekday(
    en: json['en'] as String,
    ar: json['ar'] as String,
  );
}

Map<String, dynamic> _$HijriWeekdayToJson(HijriWeekday instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ar': instance.ar,
    };
