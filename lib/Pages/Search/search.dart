import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Api/Requests/product.dart';
import 'package:ixiamobile_application/Components/productWidget.dart';

class Search extends StatefulWidget{
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  Future<List<Product>> _searchProducts;
  final productApi = ProductApi();
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text(
    "Ixia",
    style:  TextStyle(
      fontSize: 25,
      fontFamily: 'Montserrat',
    ),
  );
  String name;

  @override
  void initState() {
    super.initState();
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
            onPressed: (){
              setState(() {
                if(this.cusIcon.icon == Icons.search){
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    onSubmitted: (value){
                      setState(() {
                        name = value;
                      });
                      _searchProducts = productApi.searchProductsAsync(name);
                    },
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type here to search",
                      hintStyle: TextStyle(
                        color: Colors.white
                      )
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                }else{
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text(
                    "Ixia",
                    style:  TextStyle(
                      fontSize: 25,
                    ),
                  );
                }
              });
            },
            icon: cusIcon,
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(FontAwesomeIcons.filter),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _searchProducts,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data.length != 0){
              return ListView(
                scrollDirection: Axis.vertical,
                children: snapshot.data
                    .map((e) => ProductWidget(product: e,),).toList(),
              );
            }else if(snapshot.data.length == 0){
              return Center(
                child: Text(
                  'We\'re sorry but no product \n\n match your search input :(',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              );
            }
          }else if(snapshot.hasError){
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
