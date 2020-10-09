import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Api/Models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase.g.dart';

@JsonSerializable()
class Purchase {
  User user;
  Price price;
  DateTime purchaseTime;
  String comments;
  int quantity;

  Purchase(
      {this.user, this.price, this.purchaseTime, this.comments, this.quantity});

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseToJson(this);
}
