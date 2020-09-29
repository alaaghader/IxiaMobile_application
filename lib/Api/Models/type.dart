import 'package:ixiamobile_application/Api/Models/category.dart';
import 'package:ixiamobile_application/Api/Models/sub-category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type.g.dart';

@JsonSerializable()
class Type {
  int id;
  String name;
  Sub_Category sub_Category;

  Type({this.id, this.name, this.sub_Category});

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
