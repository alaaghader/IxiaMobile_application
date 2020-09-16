// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return Favorite(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    price: json['price'] == null
        ? null
        : Price.fromJson(json['price'] as Map<String, dynamic>),
    favoriteTime: json['favoriteTime'] == null
        ? null
        : DateTime.parse(json['favoriteTime'] as String),
  );
}

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'user': instance.user,
      'product': instance.price,
      'favoriteTime': instance.favoriteTime?.toIso8601String(),
    };
