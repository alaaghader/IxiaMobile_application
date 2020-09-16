import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Api/Models/price.dart';
import 'package:ixiamobile_application/Pages/Products/productDetail.dart';

class HomePageProductWidget extends StatelessWidget {
  final Price price;
  const HomePageProductWidget({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                price: price,
              ),
            ),
          );
        },
        child: new Card(
          elevation: 3.5,
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('res/images/myHoodie.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: 200,
                height: 150,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  price.product.name,
                  style: TextStyle(
                    fontSize: 16.0,
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
