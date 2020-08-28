import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/token_view.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class AccountApi{
  static Future<TokenView> signUp(
    String firstName,
    String lastName,
    String userName,
    String email,
    String password
      ) async {
    try{
        var response = await dio.post('api/account/signup', data: {
          "FirstName": firstName,
          "LastName": lastName,
          "UserName": userName,
          "Email": email,
          "Password": password
        });
        
        print(response);

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return TokenView.fromJson(response.data["payload"]);
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  static Future<TokenView> login(
    String email,
    String password
      ) async {
    try{
        var response = await dio.post('api/account/Login', data: {
          "Email": email,
          "Password": password
        });
        
        print(response);

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return TokenView.fromJson(response.data["payload"]);
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}