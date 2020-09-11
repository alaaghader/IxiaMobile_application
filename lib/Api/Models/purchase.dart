import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Api/Models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase.g.dart';

@JsonSerializable()
class Purchase {
  User user;
  Product product;
  DateTime purchaseTime;
  String comments;

  Purchase({this.user, this.product, this.purchaseTime, this.comments});

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseToJson(this);
}
