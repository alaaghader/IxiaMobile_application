import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Api/Models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class Favorite{
  User user;
  Product product;
  DateTime favoriteTime;

  Favorite({
    this.user,
    this.product,
    this.favoriteTime,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}