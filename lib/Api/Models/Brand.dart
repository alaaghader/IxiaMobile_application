import 'package:ixiamobile_application/Api/Models/company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Brand.g.dart';

@JsonSerializable()
class Brand {
  int id;
  String name;
  Company company;

  Brand({this.id, this.name, this.company});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}
