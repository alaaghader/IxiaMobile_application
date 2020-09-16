// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return Currency(
    id: json['id'] as int,
    currencyName: json['currencyName'] as String,
  );
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'currencyName': instance.currencyName,
    };
