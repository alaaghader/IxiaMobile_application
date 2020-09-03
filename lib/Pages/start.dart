import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Pages/Account/account.dart';
import 'MyLists/myList.dart';
import 'Products/products.dart';
import 'Search/search.dart';

class StartPage extends StatefulWidget {
  static const String route = 'home';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int pageIndex = 0 ;

  final Products _products = Products();
  final Search _search = Search();
  final MyList _myList = MyList();
  final Account _account = Account();

  Widget _showPage = new Products();

  Widget _pageChooser(int page){
    switch (page){
      case 0:
        return _products;
        break;
      case 1:
        return _search;
        break;
      case 2:
        return _myList;
        break;
      case 3:
        return _account;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text(
              'no pages found :/',
              style: new TextStyle(
                fontSize: 30
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     bottomNavigationBar: CurvedNavigationBar(
       height: 60.0,
       index: 0,
       backgroundColor: Colors.white,
       color: Colors.red,
       buttonBackgroundColor: Colors.redAccent,
       items: <Widget>[
         Icon(Icons.home, size: 20, color: Colors.white,),
         Icon(Icons.search, size: 20, color: Colors.white),
         Icon(Icons.menu, size: 20, color: Colors.white),
         Icon(Icons.account_circle, size: 20, color: Colors.white),
       ],
       animationDuration: Duration(
         milliseconds: 200,
       ),
       animationCurve: Curves.bounceInOut,
       onTap: (int tappedIndex){
         setState(() {
           _showPage = _pageChooser(tappedIndex);
         });
       },
     ),
     body: Container(
       child: Center(
         child: _showPage,
       ),
     ),
   );
  }
}