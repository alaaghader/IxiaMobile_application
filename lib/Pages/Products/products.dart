import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Pages/Products/productDetail.dart';
import 'package:ixiamobile_application/Api/Requests/product.dart';

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
                  children: snapshot.data.map((e) => ProductWidget(product: e,)).toList()
                );
              }else{
                return Text('No products found');
              }
            }else if(snapshot.hasError){
              return Text(snapshot.error);
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({
    Key key,
    this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: new Card(
        elevation: 3.5,
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: new GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(product: product,),
              ),
            );
          },
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'res/images/myHoodie.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(
                      15.0),
                ),
                width: 200,
                height: 200,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
