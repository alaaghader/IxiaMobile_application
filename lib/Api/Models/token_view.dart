import 'package:json_annotation/json_annotation.dart';

part 'token_view.g.dart';

@JsonSerializable()
class TokenView {
  String accessToken;
  String email;
  String refreshToken;
  DateTime expiresOn;
  String userId;

  TokenView({
    this.accessToken,
    this.email,
    this.refreshToken,
    this.expiresOn,
    this.userId,
  });

  factory TokenView.fromJson(Map<String, dynamic> json) =>
      _$TokenViewFromJson(json);

  Map<String, dynamic> toJson() => _$TokenViewToJson(this);
}
