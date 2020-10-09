import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Api/Models/sub-category.dart';
import 'package:ixiamobile_application/Api/Requests/price.dart';
import 'package:ixiamobile_application/Components/productWidget.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/Pages/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ixiamobile_application/utils/dio.dart';

class ExploreSubCategories extends StatefulWidget {
  final Sub_Category subCategory;

  const ExploreSubCategories({Key key, this.subCategory}) : super(key: key);
  @override
  ExploreSubCategoriesState createState() => ExploreSubCategoriesState();
}

class ExploreSubCategoriesState extends State<ExploreSubCategories> {
  Future<List<Price>> pricesFuture;
  PriceApi _priceApi = PriceApi();
  Position currentLocation;
  static LatLng _center;
  Future<void> getCurrentPosition;
  List<Placemark> placemark;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
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

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    placemark = await Geolocator().placemarkFromCoordinates(
        _center.latitude.toString().length > 9
            ? double.parse(_center.latitude.toString().substring(0, 8))
            : _center.latitude,
        _center.longitude.toString().length > 9
            ? double.parse(_center.longitude.toString().substring(0, 8))
            : _center.longitude);
    setState(() {
      pricesFuture = _priceApi.getPricesByCountryAndSubCategory(
          placemark[0].country, widget.subCategory.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ixia',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<List<Price>>(
            future: pricesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length != 0) {
                  return SingleChildScrollView(
                    child: Column(
                      children: snapshot.data
                          .map(
                            (e) => ProductWidget(
                              price: e,
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else {
                  return Center(
                    child: Text('No Products found'),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error,
                  ),
                );
              }
              return Center(
                child: Loader(),
              );
            },
          ),
        ],
      ),
    );
  }
}
