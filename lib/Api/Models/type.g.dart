// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Type _$TypeFromJson(Map<String, dynamic> json) {
  return Type(
    id: json['id'] as int,
    name: json['name'] as String,
    sub_Category: json['sub_Category'] == null
        ? null
        : Sub_Category.fromJson(json['sub_Category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sub_Category': instance.sub_Category,
    };
