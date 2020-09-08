import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Pages/Products/productDetail.dart';

class ProductWidget extends StatelessWidget{
  final Product product;

  const ProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Material(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          height: 160.0,
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(product: product,),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: min(200, MediaQuery.of(context).size.width * 0.34),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                    image: DecorationImage(
                      image:AssetImage('res/images/myHoodie.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(height: 1.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          product.company.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Expanded(
                          child: Text(
                            product.description ?? "",
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.star, color: Colors.yellow, size: 18),
                                    Icon(Icons.star, color: Colors.yellow, size: 18),
                                    Icon(Icons.star, color: Colors.yellow, size: 18),
                                    Icon(Icons.star, color: Colors.yellow, size: 18),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 18),
                                    SizedBox(width: 4.0),
                                    Text(
                                      '(234)',
                                      style: TextStyle(
                                        color: Colors.yellow,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                if (product.price == product.price)
                                  Text(
                                    '${product.price} \$',
                                    style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                Text('${product.price} \$'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}