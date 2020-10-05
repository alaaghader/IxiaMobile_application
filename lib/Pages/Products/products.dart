import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ixiamobile_application/Api/Models/category.dart';
import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Api/Models/sub-category.dart';
import 'package:ixiamobile_application/Api/Requests/category.dart';
import 'package:ixiamobile_application/Api/Requests/price.dart';
import 'package:ixiamobile_application/Api/Requests/purchase.dart';
import 'package:ixiamobile_application/Components/exploreCategories.dart';
import 'package:ixiamobile_application/Pages/loader.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';

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
  PurchaseApi _purchaseApi = PurchaseApi();
  Position currentLocation;
  static LatLng _center;
  Future<void> getCurrentPosition;
  List<Placemark> placemark;

  @override
  void initState() {
    super.initState();
    categoriesFuture = _categoryApi.getCategoriesAsync();
    subcategoryFuture = _purchaseApi.getAllSubCategoriesAsync();
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
      body: Observer(
        builder: (context) {
          var userStore = Provider.of<UserStore>(context);
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userStore.profile != null &&
                              userStore.profile.firstName != null
                          ? 'Welcome, ${userStore.profile.firstName}!'
                          : "Welcome, Ixia user",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Browse here what you need easily.',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ExploreCategories(
                                                    category: e,
                                                  )),
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
                                                          15.0),
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
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data
                                  .map(
                                    (e) => Container(
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
                      'All Products In Your Country',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FutureBuilder<List<Price>>(
                      future: pricesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return GridView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 8.0 / 10.0,
                              crossAxisCount: 2,
                            ),
                            children: snapshot.data
                                .map(
                                  (e) => Container(
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
                                                    'http://alaaghader-001-site1.gtempurl.com/api/Profile/get/${e.product.imageUrl}'),
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
                                              e.product.name,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
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
            ],
          );
        },
      ),
    );
  }
}
