import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Api/Requests/price.dart';
import 'package:ixiamobile_application/Components/productWidget.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  Future<List<Price>> pricesFuture;
  PriceApi _productApi = PriceApi();
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text(
    "Ixia",
    style: TextStyle(
      fontSize: 25,
      fontFamily: 'Montserrat',
    ),
  );
  String name;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: cusSearchBar,
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    onSubmitted: (value) {
                      setState(() {
                        name = value;
                      });
                      pricesFuture = _productApi.searchPriceAsync(
                          placemark[0].country, name);
                    },
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type here to search",
                        hintStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text(
                    "Ixia",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  );
                }
              });
            },
            icon: cusIcon,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.filter),
          ),
        ],
      ),
      body: FutureBuilder<List<Price>>(
        future: pricesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length != 0) {
              return ListView(
                scrollDirection: Axis.vertical,
                children: snapshot.data
                    .map(
                      (e) => ProductWidget(
                        price: e,
                      ),
                    )
                    .toList(),
              );
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Text(
                  'We\'re sorry but no product \n\n match your search input :(',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center(
            child: Text(
              'Type Here A Product Name To Search It',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
