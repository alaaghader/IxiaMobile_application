import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ixiamobile_application/Api/Models/product.dart';
import 'package:ixiamobile_application/Api/Requests/product.dart';
import 'package:ixiamobile_application/Pages/Products/productDetail.dart';

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
    ),
  );
  String name;

  @override
  void initState() {
    _searchProducts = productApi.searchProductsAsync(name);
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
                      initState();
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
                    .map((e) => Padding(
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
                              builder: (context) => ProductDetails(product: e,),
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
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(height: 1.0),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      e.company.name ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: Text(
                                        e.description ?? "",
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
                                            if (e.price == e.price)
                                              Text(
                                                '${e.price} \$',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    decoration: TextDecoration.lineThrough),
                                              ),
                                            Text('${e.price} \$'),
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
                ),).toList(),
              );
            }else{
              Center(
                child: Text(
                    'We\'re sorry but no product found :(',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              );
            }
          }else if(snapshot.hasError){
            return Text(snapshot.error);
          }
          return Container();
        },
      ),
    );
  }
}
