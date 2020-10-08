import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class PriceApi {
  Future<Price> addPriceAsync(
      int productId, int countryId, int currencyId, double price) async {
    try {
      var response = await dio.post('api/price/AddPrice');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return Price.fromJson(response.data["payload"]);
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Price>> getPriceAsync(String countryName) async {
    try {
      var response = await dio.get('api/price/GetPrices/$countryName');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Price.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Price>> getPricesByCountryAndCategoryAsync(
      String countryName, int categoryId) async {
    try {
      var response = await dio
          .get('api/Price/GetPricesByCategory/$countryName/$categoryId');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Price.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Price>> getPricesByCountryAndSubCategory(
      String countryName, int subCategoryId) async {
    try {
      var response = await dio
          .get('api/Price/GetPricesBySubCategory/$countryName/$subCategoryId');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Price.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Price>> searchPriceAsync(
      String countryName, String prodName) async {
    try {
      var response =
          await dio.post('api/price/SearchPrices/$countryName/$prodName');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Price.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Price>> getProductDetailsPriceAsync(
      int id, String countryName) async {
    try {
      var response =
          await dio.post('api/price/GetProductDetailsPrice/$id/$countryName');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Price.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Price>> getRecommendedAsync(
      int prodId, String countryName) async {
    try {
      var response =
          await dio.get('api/price/GetRecommended/$prodId/$countryName');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Price.fromJson(e)).toList();
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}
