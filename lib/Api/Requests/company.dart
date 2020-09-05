import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/company.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class CompanyApi{
  Future<bool> addCompanyAsync(
    String name,
    String phoneNumber,
    String email
      ) async {
    try{
      var response = await dio.post('api/company/AddCompany', data: {
        "Name": name,
        "PhoneNumber": phoneNumber,
        "Email": email
      });

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return response.data['payload']; 
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<List<Company>> getCompaniesAsync() async {
    try{
      var response = await dio.get('api/company/GetCompanies');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Company.fromJson(e)).toList();
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

    Future<Company> getCompanyDetailsAsync(
      int id
      ) async {
    try{
      var response = await dio.get('api/company/GetCompanyDetails/{$id}');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return Company.fromJson(response.data["payload"]);
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}