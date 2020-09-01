import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Api/Requests/product.dart';

class ProductDetails extends StatefulWidget{
  final Product product;

  const ProductDetails({Key key, this.product}) : super(key: key);
  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails>{
  bool pressed = false;
  Future<Product> _productFuture;
  final productApi = ProductApi();

  @override
  void initState() {
    _productFuture = productApi.getProductDetailsAsync(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ixia',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
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
                                    right: -40.0,
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
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    pressed = !pressed;
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: pressed ? Colors.red : Colors.white,
                                ),
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
                                      fontSize: 16.0
                                  ),
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
          }else if(snapshot.hasError){
            return Text(snapshot.error);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(left:20.0, right: 20.0),
          child: Padding(
            padding: const EdgeInsets.only(left:85.0, right: 85.0),
            child: RaisedButton(
              onPressed: (){},
              color: Colors.red,
              child: Text('ORDER NOW',
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

  screenAwareSize(int size, BuildContext context){
    double baseHeight = 640.0;
    return size * MediaQuery.of(context).size.height / baseHeight;
  }
}