import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Failures/failure.dart';
import 'package:ixiamobile_application/Failures/internet_failure.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/Pages/AuthenticationUI/signin.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';
import '../start.dart';

class SignUp extends StatefulWidget{
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp>{
  final _formKey = GlobalKey<FormState>();
  String _firstName = "";
  String _lastName = "";
  String _userName = "";
  String _email = "";
  String _password = "";
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

  void _signUp() async {
    if (_formKey.currentState.validate()) {
      try {
        await userStore.signUp(_firstName, _lastName, _userName, _email, _password);
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
          padding: EdgeInsets.only(top: 180.0, left: 25.0, right: 25.0),
          children: <Widget>[
            TextField(
              decoration: new InputDecoration(
                hintText: "Type Your First Name",
              ),
              onChanged: (v) => setState(() => _firstName = v),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: new InputDecoration(
                hintText: "Type Your Last Name",
              ),
              onChanged: (v) => setState(() => _lastName = v),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: new InputDecoration(
                hintText: "Type Your User Name",
              ),
              onChanged: (v) => setState(() => _userName = v),
            ),
            SizedBox(
              height: 15,
            ),
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
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)
                ),
                elevation: 2.0,
                onPressed: _signUp,
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 20.0,
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
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signin(),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red),
                    ),
                    elevation: 2.0,
                    child: Text(
                      'Login here',
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
    );
  }
}