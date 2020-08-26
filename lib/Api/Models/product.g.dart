// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    categoryId: json['categoryId'] == null
        ? null
        : Category.fromJson(json['categoryId'] as Map<String, dynamic>),
    companyId: json['companyId'] == null
        ? null
        : Company.fromJson(json['companyId'] as Map<String, dynamic>),
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    imageUrl: json['imageUrl'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'companyId': instance.companyId,
      'name': instance.name,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
