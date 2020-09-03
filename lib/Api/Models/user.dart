import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  String id;
  String firstName;
  String middleName;
  String lastName;
  DateTime birthDate;
  String address;
  String token;
  String email;

  User({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.birthDate,
    this.address,
    this.token,
    this.email,
  });

    factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}