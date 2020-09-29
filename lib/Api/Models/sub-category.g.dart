// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub-category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sub_Category _$Sub_CategoryFromJson(Map<String, dynamic> json) {
  return Sub_Category(
    id: json['id'] as int,
    name: json['name'] as String,
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$Sub_CategoryToJson(Sub_Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
    };
