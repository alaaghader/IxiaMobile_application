import 'package:ixiamobile_application/Api/Models/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub-category.g.dart';

@JsonSerializable()
class Sub_Category {
  int id;
  String name;
  Category category;

  Sub_Category({this.id, this.name, this.category});

  factory Sub_Category.fromJson(Map<String, dynamic> json) =>
      _$Sub_CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$Sub_CategoryToJson(this);
}
