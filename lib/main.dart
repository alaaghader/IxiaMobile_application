import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'Pages/entryPoint.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  ReactionDisposer _reactionDisposer;

  UserStore userStore;

  @override
  void initState() {
    userStore = UserStore();

    _reactionDisposer = reaction(
      (_) => userStore.isLoggedIn,
      (isLoggedIn) {
        if (!isLoggedIn) {
          setState(() {
            userStore = UserStore();
          });
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => userStore),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Ixia',
        theme: ThemeData(accentColor: Colors.red),
        home: EntryPoint(),
      ),
    );
  }
}
