import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ixiamobile_application/Api/Requests/account.dart';
import 'package:ixiamobile_application/Pages/start.dart';

class Login extends StatefulWidget{
 Login({Key key}) : super(key: key);

 @override
 _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
 AccountApi accountApi = AccountApi();

  @override
  void initState() {
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
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.end,
         children: [
           Container(
             alignment: Alignment.topCenter,
             margin: EdgeInsets.only(bottom: 200),
             child: Text(
               'WELCOME TO \n    IXIA APP!',
               style: TextStyle(
                 fontSize: 40,
                 fontWeight: FontWeight.bold,
                 color: Colors.redAccent
               ),
             ),
           ),
           Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(25.0)
             ),
             color: Colors.blue,
             child: ListTile(
               leading: Icon(
                 FontAwesomeIcons.facebook,
                 color: Colors.white,
               ),
               title: Text(
                   'Continue With Facebook',
                 style: TextStyle(
                   color: Colors.white,
                 ),
               ),
             ),
           ),
           Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(25.0)
             ),
             color: Colors.red,
             child: ListTile(
               onTap: (){},
               leading: Icon(
                 FontAwesomeIcons.google,
                 color: Colors.white,
               ),
               title: Text(
                 'Continue With Google',
                 style: TextStyle(
                   color: Colors.white,
                 ),
               ),
             ),
           ),
           Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(25.0)
             ),
             color: Colors.grey[500],
             child: ListTile(
               onTap: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => StartPage(),
                   ),
                 );
               },
               leading: Icon(
                 Icons.email,
                 color: Colors.white,
               ),
               title: Text(
                 'Continue With Email',
                 style: TextStyle(
                   color: Colors.white,
                 ),
               ),
             ),
           ),
         ],
       ),
     ),
   );
 }
}


