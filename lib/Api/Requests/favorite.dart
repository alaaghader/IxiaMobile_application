import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/favorite.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class FavoriteApi{
  Future<List<Favorite>> getAllFavoritesAsync() async {
    try{
      var response = await dio.get('api/favorite/GetAllFavorites');

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      Iterable mapList = response.data['payload'];
      return mapList.map((e) => Favorite.fromJson(e)).toList();
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }

  Future<bool> toggleFavoritesAsync(
    int id
      ) async {
    try{
      var response = await dio.post('api/favorite/ToggleFavorite/$id', data: id);

      if (response.statusCode >= 400) {
        throw StatusFailure.fromResponse(response);
      }

      return response.data['payload']; 
    }  on DioError catch (error) {
      throw InternetFailure(message: error.message);
    }
  }
}