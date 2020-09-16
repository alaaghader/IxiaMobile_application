import 'package:ixiamobile_application/Api/Models/country.dart';
import 'package:ixiamobile_application/Api/Models/currency.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable()
class Price {
  int productId;
  int countryId;
  int currencyId;
  double priceNumber;
  Product product;
  Currency currency;
  Country country;

  Price({
    this.productId,
    this.countryId,
    this.currencyId,
    this.priceNumber,
    this.product,
    this.currency,
    this.country,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
