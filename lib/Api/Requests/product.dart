import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class ProductApi{
  Future<bool> addProductAsync(
    int categoryId,
    int companyId,
    String name,
    double price,
    String imageUrl,
    String description,
      ) async {
    try{
      var response = await dio.post('api/product/AddProduct', data: {
        "CategoryId": categoryId,
        "CompanyId": companyId,
        "Name": name,
        "Price": price,
        "ImageUrl": imageUrl,
        "Description": description,
      });

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return response.data['payload']; 
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Product>> getAllProductAsync() async {
    try{
      var response = await dio.get('api/product/GetAllProduct');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Product.fromJson(e)).toList();
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<Product> getProductDetailsAsync(
      int id,
      ) async {
    try{
      var response = await dio.post('api/product/GetProductDetails/$id');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return Product.fromJson(response.data["payload"]);
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Product>> searchProductsAsync(
      String name
      ) async {
    try{
      var response = await dio.post('api/product/SearchProduct',data: {
        "Name":name,
      });

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Product.fromJson(e)).toList();
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}