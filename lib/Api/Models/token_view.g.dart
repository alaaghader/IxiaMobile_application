// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenView _$TokenViewFromJson(Map<String, dynamic> json) {
  return TokenView(
    accessToken: json['accessToken'] as String,
    email: json['email'] as String,
    refreshToken: json['refreshToken'] as String,
    expiresOn: json['expiresOn'] == null
        ? null
        : DateTime.parse(json['expiresOn'] as String),
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$TokenViewToJson(TokenView instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'email': instance.email,
  'refreshToken': instance.refreshToken,
  'expiresOn': instance.expiresOn?.toIso8601String(),
  'userId': instance.userId,
};