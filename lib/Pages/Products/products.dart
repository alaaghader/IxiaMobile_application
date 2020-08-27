import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Pages/Products/productDetail.dart';

class Products extends StatelessWidget {
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
        body: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 8.0 / 10.0,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.all(6.0),
                child: Card(
                    elevation: 3.5,
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('res/images/myHoodie.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "product",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                    )
                )
            );
          },
        )
    );
  }
}
