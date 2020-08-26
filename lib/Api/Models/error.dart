import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class Error {
  String code;
  String description;
  String path;

  Error({this.code, this.description, this.path});

  factory Error.fromJson(json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
