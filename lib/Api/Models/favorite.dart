import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Api/Models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class Favorite {
  User user;
  Price price;
  DateTime favoriteTime;

  Favorite({
    this.user,
    this.price,
    this.favoriteTime,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
