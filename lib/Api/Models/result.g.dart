// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result<T> _$ResultFromJson<T>(Map<String, dynamic> json) {
  return Result<T>(
    status: json['status'] as int,
    errors: (json['errors'] as List)
        ?.map((e) => e == null ? null : Error.fromJson(e))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson<T>(Result<T> instance) => <String, dynamic>{
  'status': instance.status,
  'errors': instance.errors,
};