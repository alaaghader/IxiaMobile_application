import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company{
  int id;
  String name;
  String phoneNumber;
  String email;
  List<Product> products;

  Company({
    this.id,
    this.name,
    this.phoneNumber,
    this.products
  });

    factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}