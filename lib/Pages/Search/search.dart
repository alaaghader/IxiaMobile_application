import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatefulWidget{
  @override
  SearchState createState() => SearchState();
}
class SearchState extends State<Search> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text(
    "Ixia",
    style:  TextStyle(
      fontSize: 25,
    ),
  );

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
    );
  }
}
