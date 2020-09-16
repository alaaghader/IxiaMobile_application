import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/country.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class CountryApi {
  Future<Country> addCountryAsync(String countryName) async {
    try {
      var response = await dio.post('api/country/AddCountry');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return Country.fromJson(response.data["payload"]);
    } on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}
