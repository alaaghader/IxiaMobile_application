import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/purchase.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class PurchaseApi{
  Future<List<Purchase>> getAllPurchasesAsync(
    String id,
      ) async {
    try{
        var response = await dio.get('api/purchase/GetAllPurchases/{$id}');
        
        print(response);

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Purchase.fromJson(e)).toList();
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<bool> toggleFavoritesAsync(
    String id,
    int prodId,
    String comments
      ) async {
    try{
        var response = await dio.post('api/purchase/TogglePurchase', data: {
          "Id": id,
          "ProdId": prodId,
          "Comments": comments
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