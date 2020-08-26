import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget{
  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails>{
  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'res/images/hoodie.jpg'
              ),
              fit: BoxFit.cover,
          ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product details'),
        backgroundColor: Colors.red,
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled){
            return[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Stack(
                      fit: StackFit.loose,
                      overflow: Overflow.clip,
                        children: <Widget>[
                          Column(
                            children: <Widget> [
                              _buildCoverImage(screenSize)
                            ],
                          ),
                        ],
                    ),
                  ],
                ),
              ),
            ];
          },
          scrollDirection: Axis.vertical,
          body: TabBarView(
            children: <Widget>[
              Text(''),
            ],
          ),
        ),
    );
  }
}