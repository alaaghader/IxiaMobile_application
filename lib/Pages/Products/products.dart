import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Api/Requests/price.dart';
import 'package:ixiamobile_application/Components/homePageProductWidget.dart';
import 'package:ixiamobile_application/Pages/loader.dart';

class Products extends StatefulWidget {
  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products> {
  Future<List<Price>> pricesFuture;
  PriceApi _productApi = PriceApi();
  Position currentLocation;
  static LatLng _center;
  Future<void> getCurrentPosition;
  List<Placemark> placemark;

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  Future<Position> locateUser() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
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
      pricesFuture = _productApi.getPriceAsync(placemark[0].country);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: FutureBuilder<List<Price>>(
        future: pricesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length != 0) {
              return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8.0 / 10.0,
                    crossAxisCount: 2,
                  ),
                  children: snapshot.data
                      .map((e) => HomePageProductWidget(
                            price: e,
                          ))
                      .toList());
            } else {
              return Center(
                child: Text(
                  'No products found',
                  style: TextStyle(fontSize: 25.0),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center(
            child: Loader(),
          );
        },
      ),
    );
  }
}
