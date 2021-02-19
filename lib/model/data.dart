import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class ResponseData {
  int code;
  String status;
  Data data;
  ResponseData({
    this.code,
    this.status,
    this.data,
  });
  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

@JsonSerializable()
class Data {
  Hijri hijri;
  Hijri gregorian;

  Data({this.hijri, this.gregorian});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Gregorian {
  String date;
  String format;
  String day;
  GregorianWeekday weekday;
  GregorianMonth month;
  String year;
  Designation designation;

  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) =>
      _$GregorianFromJson(json);
  Map<String, dynamic> toJson() => _$GregorianToJson(this);
}

@JsonSerializable()
class Designation {
  String abbreviated;
  String expanded;

  Designation({
    this.abbreviated,
    this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) =>
      _$DesignationFromJson(json);
  Map<String, dynamic> toJson() => _$DesignationToJson(this);
}

@JsonSerializable()
class GregorianMonth {
  int number;
  String en;

  GregorianMonth({
    this.number,
    this.en,
  });

  factory GregorianMonth.fromJson(Map<String, dynamic> json) =>
      _$GregorianMonthFromJson(json);
  Map<String, dynamic> toJson() => _$GregorianMonthToJson(this);
}

@JsonSerializable()
class GregorianWeekday {
  String en;

  GregorianWeekday({
    this.en,
  });

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) =>
      _$GregorianWeekdayFromJson(json);
  Map<String, dynamic> toJson() => _$GregorianWeekdayToJson(this);
}

@JsonSerializable()
class Hijri {
  String date;
  String format;
  String day;
  HijriWeekday weekday;
  HijriMonth month;
  String year;
  Designation designation;
  List<dynamic> holidays;

  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.holidays,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) => _$HijriFromJson(json);
  Map<String, dynamic> toJson() => _$HijriToJson(this);
}

@JsonSerializable()
class HijriMonth {
  int number;
  String en;
  String ar;

  HijriMonth({
    this.number,
    this.en,
    this.ar,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) =>
      _$HijriMonthFromJson(json);
  Map<String, dynamic> toJson() => _$HijriMonthToJson(this);
}

@JsonSerializable()
class HijriWeekday {
  String en;
  String ar;

  HijriWeekday({
    this.en,
    this.ar,
  });

  factory HijriWeekday.fromJson(Map<String, dynamic> json) =>
      _$HijriWeekdayFromJson(json);
  Map<String, dynamic> toJson() => _$HijriWeekdayToJson(this);
}
