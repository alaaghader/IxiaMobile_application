import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Components/homePageProductWidget.dart';
import 'package:ixiamobile_application/Components/productWidget.dart';
import 'package:ixiamobile_application/Pages/Products/productDetail.dart';
import 'package:ixiamobile_application/Api/Requests/product.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products>{
  Future<List<Product>> products;
  ProductApi _productApi = ProductApi();

  @override
  void initState() {
    products = _productApi.getAllProductAsync();
    super.initState();
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
        body: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              if(snapshot.data.length != 0){
                return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8.0 / 10.0,
                    crossAxisCount: 2,
                  ),
                  children: snapshot.data.map((e) => HomePageProductWidget(product: e,)).toList()
                );
              }else{
                return Text('No products found');
              }
            }else if(snapshot.hasError){
              return Text(snapshot.error);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
    );
  }
}
