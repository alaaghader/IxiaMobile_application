import 'package:ixiamobile_application/Api/Models/company.dart';
import 'package:ixiamobile_application/Api/Models/type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int id;
  Type type;
  Company company;
  String name;
  double price;
  String imageUrl;
  String description;
  bool isFavorite;
  int totalFavorite;

  Product({
    this.id,
    this.type,
    this.company,
    this.name,
    this.price,
    this.imageUrl,
    this.description,
    this.isFavorite,
    this.totalFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
