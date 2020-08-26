import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class CategoryApi{
  Future<bool> addCategoryAsync(
    String name,
    String description
      ) async {
    try{
        var response = await dio.post('api/category/AddCategory', data: {
          "Name": name,
          "Description": description,
        });
        
        print(response);

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return response.data['payload']; 
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}