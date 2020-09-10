import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company {
  int id;
  String name;
  String phoneNumber;
  String email;
  //List<Product> products;
  double lat;
  double lon;
  String photoUrl;

  Company({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    //this.products,
    this.lat,
    this.lon,
    this.photoUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
