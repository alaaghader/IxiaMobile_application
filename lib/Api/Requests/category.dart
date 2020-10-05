import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/category.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class CategoryApi {
  Future<bool> addCategoryAsync(String name, String description) async {
    try {
      var response = await dio.post('api/category/AddCategory', data: {
        "Name": name,
        "Description": description,
      });

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return response.data['payload'];
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Category>> getCategoriesAsync() async {
    try {
      var response = await dio.get('api/category/getCategories');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Category.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}
