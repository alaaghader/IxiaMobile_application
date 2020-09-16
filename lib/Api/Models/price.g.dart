// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) {
  return Price(
    productId: json['productId'] as int,
    countryId: json['countryId'] as int,
    currencyId: json['currencyId'] as int,
    priceNumber: (json['priceNumber'] as num)?.toDouble(),
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    currency: json['currency'] == null
        ? null
        : Currency.fromJson(json['currency'] as Map<String, dynamic>),
    country: json['country'] == null
        ? null
        : Country.fromJson(json['country'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'productId': instance.productId,
      'countryId': instance.countryId,
      'currencyId': instance.currencyId,
      'priceNumber': instance.priceNumber,
      'product': instance.product,
      'currency': instance.currency,
      'country': instance.country,
    };
