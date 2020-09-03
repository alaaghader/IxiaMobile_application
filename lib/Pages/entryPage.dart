import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as Http;
import 'package:ixiamobile_application/Failures/failure.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/Pages/start.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';
import 'AuthenticationUI/signin.dart';
import 'AuthenticationUI/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EntryPage extends StatefulWidget {
  @override
  EntryPageState createState() => EntryPageState();
}

class EntryPageState extends State<EntryPage>{
  Map userProfile;
  final fblogin = new FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  UserStore userStore;

  @override
  void didChangeDependencies() {
    userStore = Provider.of<UserStore>(context);
    super.didChangeDependencies();
  }

  void _showAlert(Failure failure) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(failure.message),
          content: Builder(
            builder: (context) {
              if (failure is InternetFailure) {
                return Text("Please try again!");
              } else if (failure is StatusFailure) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (failure.errors != null)
                      ...failure.errors.map((e) => Text(e.description)).toList()
                  ],
                );
              }
              return Text("Something unexpected happened");
            },
          ),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  void _goToEntryPoint() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartPage(),
      ),
    );
  }

  _googleLogin() async {
    try{
      await _googleSignIn.signIn();
      try {
        await userStore.googleLogin(_googleSignIn.currentUser.email);
        _goToEntryPoint();
      } on Failure catch (failure) {
        _showAlert(failure);
      }
    } catch (err){
      print(err);
    }
  }

  _facebookLogin() async {
    final result = await fblogin.logInWithReadPermissions(['email']);
    
    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await Http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        setState(() {
          userProfile = profile;
        });
        try {
          await userStore.facebookLogin(userProfile['email']);
          _goToEntryPoint();
        } on Failure catch (failure) {
          _showAlert(failure);
        }
        break;

      case FacebookLoginStatus.cancelledByUser:
        break;

      case FacebookLoginStatus.error:
         break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: Colors.deepPurple,
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
                  Icons.skip_next,
                  color: Colors.white,
                ),
                title: Text(
                  'Continue Without Logging in',
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
              color: Colors.blue,
              child: ListTile(
                onTap: (){
                  _facebookLogin();
                },
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
                onTap: (){
                  _googleLogin();
                },
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
                      builder: (context) => Signin(),
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