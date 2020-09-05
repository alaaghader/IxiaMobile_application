import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/user.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class ProfileApi{
  static Future<User> getUserAsync([String id]) async {
    try{
      var response = await dio.get('api/profile/${id ?? ''}');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return User.fromJson(response.data["payload"]);
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  static Future<User> updateProfileAsync(
    String firstName,
    String middleName,
    String lastName,
    //DateTime birthDate,
    String address
      ) async {
    try{
        var response = await dio.post('api/profile/EditProfile',data: {
          "FirstName": firstName,
          "MiddleName": middleName,
          "LastName": lastName,
          //"BirthDate": birthDate,
          "Address": address
        });

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

        return User.fromJson(response.data["payload"]);
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}