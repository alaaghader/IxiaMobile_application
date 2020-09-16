import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/currency.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class CurrencyApi {
  Future<Currency> addCurrencyAsync(String currencyName) async {
    try {
      var response = await dio.post('api/currency/AddCurrency');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return Currency.fromJson(response.data["payload"]);
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}
