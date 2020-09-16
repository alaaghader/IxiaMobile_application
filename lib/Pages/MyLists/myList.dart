import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ixiamobile_application/Api/Models/favorite.dart';
import 'package:ixiamobile_application/Api/Models/purchase.dart';
import 'package:ixiamobile_application/Api/Requests/favorite.dart';
import 'package:ixiamobile_application/Api/Requests/purchase.dart';
import 'package:ixiamobile_application/Components/productWidget.dart';
import 'package:ixiamobile_application/Pages/AuthenticationUI/signin.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';

class MyList extends StatefulWidget {
  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<MyList> {
  Future<List<Purchase>> getPurchases;
  Future<List<Favorite>> getFavorites;
  final purchases = PurchaseApi();
  final favorites = FavoriteApi();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Purchases',
              ),
              Tab(
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: Observer(
          builder: (context) {
            var userStore = Provider.of<UserStore>(context);
            if (userStore.isLoggedIn) {
              getPurchases = purchases.getAllPurchasesAsync();
              getFavorites = favorites.getAllFavoritesAsync();
              return TabBarView(
                children: <Widget>[
                  FutureBuilder<List<Purchase>>(
                    future: getPurchases,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data.length != 0) {
                          return ListView(
                            scrollDirection: Axis.vertical,
                            children: snapshot.data
                                .map(
                                  (e) => ProductWidget(
                                    price: e.price,
                                  ),
                                )
                                .toList(),
                          );
                        } else {
                          return Center(
                            child: Text('You don\'t have any purchase yet'),
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
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  FutureBuilder<List<Favorite>>(
                    future: getFavorites,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data.length != 0) {
                          return ListView(
                            scrollDirection: Axis.vertical,
                            children: snapshot.data
                                .map(
                                  (e) => ProductWidget(
                                    price: e.price,
                                  ),
                                )
                                .toList(),
                          );
                        } else {
                          return Center(
                            child: Text(
                                'You don\'t have any favorite product yet'),
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
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: FlatButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signin(),
                      ),
                    );
                  },
                  icon: Icon(Icons.lock),
                  label: Text("Please Login To Enter To This Page"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
