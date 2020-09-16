// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return Purchase(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    price: json['price'] == null
        ? null
        : Price.fromJson(json['price'] as Map<String, dynamic>),
    purchaseTime: json['purchaseTime'] == null
        ? null
        : DateTime.parse(json['purchaseTime'] as String),
    comments: json['comments'] as String,
  );
}

Map<String, dynamic> _$PurchaseToJson(Purchase instance) => <String, dynamic>{
      'user': instance.user,
      'product': instance.price,
      'purchaseTime': instance.purchaseTime?.toIso8601String(),
      'comments': instance.comments,
    };
