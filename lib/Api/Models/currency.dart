import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency {
  int id;
  String currencyName;

  Currency({
    this.id,
    this.currencyName,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
