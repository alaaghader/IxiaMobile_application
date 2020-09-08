import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/purchase.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class PurchaseApi{
  Future<List<Purchase>> getAllPurchasesAsync() async {
    try{
      var response = await dio.get('api/purchase/GetAllPurchases');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Purchase.fromJson(e)).toList();
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<bool> addPurchaseAsync(
    int prodId,
    String comments
      ) async {
    try{
      var response = await dio.post('api/purchase/AddPurchase/$prodId', data: {
        "ProdId": prodId,
        "Comments": comments
      });

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return response.data['payload']; 
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}