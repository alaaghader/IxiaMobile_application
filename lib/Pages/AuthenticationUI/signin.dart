import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Failures/failure.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/Pages/AuthenticationUI/signup.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';

import '../start.dart';

class Signin extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  UserStore userStore;

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StartPage(),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    userStore = Provider.of<UserStore>(context);
    super.didChangeDependencies();
  }

  void _signin() async {
    if (_formKey.currentState.validate()) {
      try {
        await userStore.login(_email, _password);
        _goToEntryPoint();
      } on Failure catch (failure) {
        _showAlert(failure);
      }
    }
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
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 35.0, right: 35.0, top: 250.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: new InputDecoration(
                      hintText: "Type Your Email",
                    ),
                    onChanged: (v) => setState(() => _email = v),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: new InputDecoration(
                      hintText: "Type Your Password",
                    ),
                    onChanged: (v) => setState(() => _password = v),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                      elevation: 2.0,
                      onPressed: _signin,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        RaisedButton(
                          color: Colors.red,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                          elevation: 2.0,
                          child: Text(
                            'Sign up here',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
