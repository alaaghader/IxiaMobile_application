import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ixiamobile_application/Api/Models/category.dart';
import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Api/Models/sub-category.dart';
import 'package:ixiamobile_application/Api/Requests/category.dart';
import 'package:ixiamobile_application/Api/Requests/price.dart';
import 'package:ixiamobile_application/Api/Requests/subCategory.dart';
import 'package:ixiamobile_application/Components/exploreCategories.dart';
import 'package:ixiamobile_application/Components/exploreSubCategories.dart';
import 'package:ixiamobile_application/Pages/loader.dart';

class Products extends StatefulWidget {
  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products> {
  Future<List<Price>> pricesFuture;
  PriceApi _priceApi = PriceApi();
  Future<List<Category>> categoriesFuture;
  CategoryApi _categoryApi = CategoryApi();
  Future<List<Sub_Category>> subcategoryFuture;
  SubCategoryApi _subCategoryApi = SubCategoryApi();
  Position currentLocation;
  static LatLng _center;
  Future<void> getCurrentPosition;
  List<Placemark> placemark;

  @override
  void initState() {
    super.initState();
    categoriesFuture = _categoryApi.getCategoriesAsync();
    subcategoryFuture = _subCategoryApi.getAllSubCategoriesAsync();
    getUserLocation();
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
      pricesFuture = _priceApi.getPriceAsync(placemark[0].country);
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
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'All Categories',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                FutureBuilder<List<Category>>(
                  future: categoriesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: snapshot.data
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      subcategoryFuture = null;
                                      subcategoryFuture = _subCategoryApi
                                          .getSubCategoryAsync(e.id);
                                    });
                                  },
                                  child: Container(
                                    height: 250,
                                    child: Card(
                                      elevation: 3.5,
                                      semanticContainer: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: new Column(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: new NetworkImage(
                                                    'http://alaaghader-001-site1.gtempurl.com/api/Profile/get/${e.photoUrl}'),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            width: 200,
                                            height: 200,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              e.name,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    } else {
                      return Center(
                        child: Loader(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'All Sub-Categories',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                FutureBuilder<List<Sub_Category>>(
                  future: subcategoryFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.length != 0) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: snapshot.data
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ExploreSubCategories(
                                            subCategory: e,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 250,
                                      child: Card(
                                        elevation: 3.5,
                                        semanticContainer: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: new Column(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: new NetworkImage(
                                                      'http://alaaghader-001-site1.gtempurl.com/api/Profile/get/${e.photoUrl}'),
                                                  fit: BoxFit.fill,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  15.0,
                                                ),
                                              ),
                                              width: 200,
                                              height: 200,
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                e.name,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      } else {
                        return Text("Nothing found");
                      }
                    } else {
                      return Center(
                        child: Loader(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
