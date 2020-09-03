import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Pages/Products/productDetail.dart';

class HomePageProductWidget extends StatelessWidget {
  final Product product;
  const HomePageProductWidget({
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