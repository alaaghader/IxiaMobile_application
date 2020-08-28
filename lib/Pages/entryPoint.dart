import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ixiamobile_application/Failures/failure.dart';
import 'package:ixiamobile_application/Pages/start.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';

import 'AuthenticationUI/signup.dart';

class EntryPoint extends StatefulWidget{
  EntryPoint({Key key}) : super(key: key);

 @override
 _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>{
  UserStore _userStore;
  Future<void> _future;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _userStore = Provider.of<UserStore>(context);

    if (_future == null) {
      _future = _fetchStatus();
    }
    super.didChangeDependencies();
  }

  Future<void> _fetchStatus() async {
    await (_userStore.hasLoadedToken
        ? Future.value(_userStore.tokenView)
        : _userStore.loadToken());
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
     body:  SafeArea(
       child: FutureBuilder<void>(
         future: _future,
         builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
           if (snapshot.connectionState == ConnectionState.done) {
             if (snapshot.hasData || _userStore.hasLoadedToken) {
               WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                 if (_userStore.isLoggedIn) {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => StartPage(),
                     ),
                   );
                 } else {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => EntryPage(),
                     ),
                   );
                 }
               });
             } else if (snapshot.hasError) {
               WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                 var error = snapshot.error;
                 if (error is Failure) {
                   Scaffold.of(context).showSnackBar(error.toSnackBar());
                 }
               });
             }
           }
           return CircularProgressIndicator();
         },
       ),
     ),
   );
 }
}

class EntryPage extends StatelessWidget {
  const EntryPage({
    Key key,
  }) : super(key: key);

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
                      builder: (context) => SignUp(),
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


