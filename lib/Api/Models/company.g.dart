// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    id: json['id'] as int,
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    email: json['email'] as String,
    // products: (json['products'] as List)
    //     ?.map((e) =>
    // e == null ? null : Product.fromJson(e as Map<String, dynamic>))
    //     ?.toList(),
    lat: (json['lat'] as num)?.toDouble(),
    lon: (json['lon'] as num)?.toDouble(),
    photoUrl: json['photoUrl'] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      //'products': instance.products,
      'lat': instance.lat,
      'lon': instance.lon,
      'photoUrl': instance.phoneNumber,
    };
