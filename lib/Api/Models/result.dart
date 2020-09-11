import 'package:json_annotation/json_annotation.dart';

import 'error.dart';

part 'result.g.dart';

@JsonSerializable()
class Result<T> {
  int status;
  List<Error> errors;

  @JsonKey(ignore: true)
  T payload;

  bool get succeeded => status < 400 && errors.isEmpty;

  Result({this.status, this.payload, this.errors});

  factory Result.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return _$ResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
