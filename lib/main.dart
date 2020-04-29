import 'package:flutter/material.dart';
import 'package:login/screens/map/favouriteList.dart';
import 'package:login/screens/login/login.dart';
import 'package:login/screens/map/map_cmb.dart';
import 'package:login/screens/login/resetPassword.dart';
import 'package:login/screens/map/supermarket_list.dart';
import 'package:login/screens/login/signup.dart';
import 'package:login/screens/splashScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        '/home': (BuildContext context) => new SuperMarketLists(),
        '/bhome': (BuildContext context) => new SuperMarketLists(),
        '/login': (BuildContext context) => new LoginPage(),
        '/map': (BuildContext context) => new SuperMarketMapsView(),
        '/resetPass': (BuildContext context) => new ResetPassword(),
        '/favlist': (BuildContext context) => new FavouriteList(),
      },
      home: new SplashScreen(),
    );
  }
}
