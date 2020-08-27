import 'package:flutter/material.dart';
import 'Pages/AuthenticationUI/login.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData(
         accentColor: Colors.red
     ),
     debugShowCheckedModeBanner: false,
     home:Login(),
   );
 }
}

