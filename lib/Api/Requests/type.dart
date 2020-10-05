import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/type.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class TypeApi {
  Future<List<Type>> getTypeAsync(int id) async {
    try {
      var response = await dio.get('api/Type/gettype/$id');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Type.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Type>> getAllTypesAsync() async {
    try {
      var response = await dio.get('api/Type/getalltypes');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Type.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}
