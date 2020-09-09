import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Api/Requests/favorite.dart';
import 'package:ixiamobile_application/Api/Requests/product.dart';
import 'package:ixiamobile_application/Api/Requests/purchase.dart';
import 'package:ixiamobile_application/Failures/failure.dart';
import 'package:ixiamobile_application/Pages/AuthenticationUI/signin.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({Key key, this.product}) : super(key: key);
  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  bool pressed = false;
  Future<Product> _productFuture;
  final productApi = ProductApi();
  final favoriteApi = FavoriteApi();
  final purchaseApi = PurchaseApi();
  String comments;

  @override
  void initState() {
    _productFuture = productApi.getProductDetailsAsync(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
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
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            pressed = snapshot.data.isFavorite;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 80.0,
                      ),
                      Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0.0,
                            right: 0,
                            child: Container(
                              width: 240,
                              height: 85,
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
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 25.0,
                                    right: -70.0,
                                    child: Container(
                                      width: 160.0,
                                      height: 40.0,
                                      child: Text(
                                        '${widget.product.price}\$',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Montserrat",
                                          fontSize: 25.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Container(
                              width: double.infinity,
                              height: screenAwareSize(250, context),
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 18.0),
                                    child: Container(
                                      child: Image.asset(
                                        'res/images/myHoodie.png',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20.0,
                            bottom: 0.0,
                            child: RawMaterialButton(
                              onPressed: null,
                              constraints: const BoxConstraints(
                                minHeight: 45.0,
                                minWidth: 45.0,
                              ),
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return IconButton(
                                    onPressed: () async {
                                      if (userStore.isLoggedIn) {
                                        try {
                                          await favoriteApi
                                              .toggleFavoritesAsync(
                                                  snapshot.data.id);
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
                                    icon: Icon(
                                      Icons.favorite,
                                      color:
                                          pressed ? Colors.red : Colors.white,
                                    ),
                                  );
                                },
                              ),
                              elevation: 5.0,
                              shape: CircleBorder(),
                              fillColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          widget.product.name,
                          style: TextStyle(
                            //color: Color(0xFFFEFEFE),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 90,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 40.0),
                        child: Text(
                          widget.product.description,
                          style: const TextStyle(
                            // color: const Color(0xFEFEFEFE),
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center(child: CircularProgressIndicator());
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
                _showDialog(userStore, widget.product.id);
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

  void _showDialog(UserStore profile, int prodId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(profile.isLoggedIn
                ? "Add a comment"
                : "You're not logged in, please login to add an order"),
            content: profile.isLoggedIn
                ? new TextField(
                    onChanged: (v) {
                      comments = v;
                    },
                  )
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
                        try {
                          await purchaseApi.addPurchaseAsync(prodId, comments);
                          Navigator.of(context).pop();
                        } on Failure catch (e) {
                          Scaffold.of(context).showSnackBar(e.toSnackBar());
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

  screenAwareSize(int size, BuildContext context) {
    double baseHeight = 640.0;
    return size * MediaQuery.of(context).size.height / baseHeight;
  }
}
