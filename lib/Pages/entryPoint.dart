import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Failures/failure.dart';
import 'package:ixiamobile_application/Pages/loader.dart';
import 'package:ixiamobile_application/Pages/start.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';
import 'entryPage.dart';

class EntryPoint extends StatefulWidget {
  EntryPoint({Key key}) : super(key: key);

  @override
  _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
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
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData || _userStore.hasLoadedToken) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (_userStore.isLoggedIn) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartPage(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
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
            return Center(child: Loader());
          },
        ),
      ),
    );
  }
}
