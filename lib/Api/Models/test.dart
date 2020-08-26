import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

@JsonSerializable()
class Test{
  int id;
  String name;
  String phoneNumber;
  String email;

  Test({
    this.id,
    this.name,
    this.phoneNumber,
    this.email});

  factory Test.fromJson(Map<String, dynamic> json) =>
      _$TestFromJson(json);

  Map<String, dynamic> toJson() => _$TestToJson(this);
}