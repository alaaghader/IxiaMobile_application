import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Api/Requests/favorite.dart';
import 'package:ixiamobile_application/Api/Requests/price.dart';
import 'package:ixiamobile_application/Api/Requests/purchase.dart';
import 'package:ixiamobile_application/Failures/failure.dart';
import 'package:ixiamobile_application/Pages/AuthenticationUI/signin.dart';
import 'package:ixiamobile_application/Pages/loader.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Price price;

  const ProductDetails({Key key, this.price}) : super(key: key);
  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  final favoriteApi = FavoriteApi();
  final purchaseApi = PurchaseApi();
  Future<List<Price>> priceFuture;
  PriceApi _priceApi = PriceApi();
  String comments;
  int quantity = 0;
  List<Placemark> placemarkCompany;
  String companyAdress;
  Position currentLocation;
  static LatLng _center;
  Future<void> getCurrentPosition;
  List<Placemark> placemark;

  getCompanyLocation() async {
    placemarkCompany = await Geolocator().placemarkFromCoordinates(
        widget.price.product.company.lat.toString().length > 9
            ? double.parse(
                widget.price.product.company.lat.toString().substring(0, 8))
            : widget.price.product.company.lat,
        widget.price.product.company.lon.toString().length > 9
            ? double.parse(
                widget.price.product.company.lon.toString().substring(0, 8))
            : widget.price.product.company.lon);
    setState(() {
      companyAdress = placemarkCompany[0].name;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
    getCompanyLocation();
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
      priceFuture = _priceApi.getRecommendedAsync(
          widget.price.product.id, placemark[0].country);
    });
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: new NetworkImage(
                  'http://alaaghader-001-site1.gtempurl.com/api/Profile/get/${widget.price.product.imageUrl}'),
              fit: BoxFit.fill)),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool pressed = widget.price.product.isFavorite;
    var userStore = Provider.of<UserStore>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.price.product.name == null
            ? "IXIA product"
            : widget.price.product.name),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<Price>>(
        future: priceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StatefulBuilder(
              builder: (context, setState) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Stack(
                              fit: StackFit.loose,
                              overflow: Overflow.clip,
                              children: <Widget>[
                                _buildCoverImage(screenSize),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListView(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 8.0),
                              width: 200,
                              height: 50,
                              decoration: new BoxDecoration(
                                color: Color.fromRGBO(32, 32, 32, 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 16),
                                    offset: Offset(0, 3),
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Price:',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat",
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        '${widget.price.priceNumber}  ${widget.price.currency.currencyName}',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Montserrat",
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 80.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5.0),
                                    child: Text(
                                      widget.price.product.totalFavorite
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat",
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  RawMaterialButton(
                                    onPressed: null,
                                    constraints: const BoxConstraints(
                                      minHeight: 45.0,
                                      minWidth: 45.0,
                                    ),
                                    elevation: 5.0,
                                    shape: CircleBorder(),
                                    fillColor: Colors.grey,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color:
                                            pressed ? Colors.red : Colors.white,
                                      ),
                                      onPressed: () async {
                                        if (userStore.isLoggedIn) {
                                          try {
                                            await favoriteApi
                                                .toggleFavoritesAsync(
                                                    widget.price.product.id,
                                                    widget.price.countryId,
                                                    widget.price.currencyId);
                                            setState(() {
                                              pressed = !pressed;
                                            });
                                          } on Failure catch (e) {
                                            Scaffold.of(context)
                                                .showSnackBar(e.toSnackBar());
                                          }
                                        } else {
                                          _showLoginDialog();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          width: 20,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Color(0xFFFFFFFF),
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: new Text(
                              "Details",
                              style: const TextStyle(
                                  color: const Color(0xEEFFEFEF),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Category",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            ),
                            Text(
                              "Sub-Category",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            ),
                            Text(
                              "Type",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "  ${widget.price.product.type.sub_Category.category.name}",
                              style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                            ),
                            Text(
                              "   ${widget.price.product.type.sub_Category.name}",
                              style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                            ),
                            Text(
                              " ${widget.price.product.type.name}",
                              style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Description:",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: widget.price.product.description == null
                                    ? Text(
                                        " There is no description for this product",
                                      )
                                    : Text(
                                        " ${widget.price.product.description}",
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          width: 20,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Color(0xFFFFFFFF),
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: new Text(
                              "Company",
                              style: const TextStyle(
                                  color: const Color(0xEEFFEFEF),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Company Name",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            ),
                            Text(
                              "Company Adress",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              " ${widget.price.product.company.name}",
                              style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                            ),
                            Text(
                              '$companyAdress',
                              style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          width: 20,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Color(0xFFFFFFFF),
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: new Text(
                              "Recommended",
                              style: const TextStyle(
                                  color: const Color(0xEEFFEFEF),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Montserrat",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: snapshot.data.length != 0
                              ? SingleChildScrollView(
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
                                                        ProductDetails(
                                                          price: e,
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
                                                      BorderRadius.circular(
                                                          10.0),
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
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      width: 200,
                                                      height: 200,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10.0),
                                                      alignment:
                                                          Alignment.center,
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
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.all(8.0),
                                  child: Text('No recommended products found'),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Loader(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 85.0, right: 85.0),
            child: RaisedButton(
              onPressed: () {
                _showDialog(userStore, widget.price.product.id,
                    widget.price.countryId, widget.price.currencyId);
              },
              color: Colors.red,
              child: Text(
                'ORDER NOW',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(
      UserStore profile, int prodId, int countryId, int currencyId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(profile.isLoggedIn
                ? "Add a comment"
                : "You're not logged in, please login to add an order"),
            content: profile.isLoggedIn
                ? Container(
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        new TextField(
                          decoration: InputDecoration(
                              hintText: 'Enter a comment if you want'),
                          onChanged: (v) {
                            comments = v;
                          },
                        ),
                        new TextField(
                          decoration:
                              InputDecoration(hintText: 'Enter the quantity'),
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            quantity = int.parse(v);
                          },
                        ),
                      ],
                    ))
                : new SizedBox(
                    height: 10,
                  ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              profile.isLoggedIn
                  ? new FlatButton(
                      child: new Text('Add Order'),
                      onPressed: () async {
                        if (quantity < 1) {
                          _showErrorDialog();
                        } else {
                          try {
                            await purchaseApi.addPurchaseAsync(prodId,
                                countryId, currencyId, comments, quantity);
                            Navigator.of(context).pop();
                          } on Failure catch (e) {
                            Scaffold.of(context).showSnackBar(e.toSnackBar());
                          }
                        }
                      },
                    )
                  : new FlatButton(
                      child: new Text('Login'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signin(),
                          ),
                        );
                      },
                    )
            ],
          );
        });
  }

  void _showLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
                "You're not logged in, please login to add a favorite"),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Login'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signin(),
                    ),
                  );
                },
              )
            ],
          );
        });
  }

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("The quantity must be greater or equal to 1"),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Got it'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  screenAwareSize(int size, BuildContext context) {
    double baseHeight = 640.0;
    return size * MediaQuery.of(context).size.height / baseHeight;
  }
}
