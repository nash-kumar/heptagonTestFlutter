import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/data_list.dart';
import 'package:splashscreen/splashscreen.dart';
import 'utilities/shared_preference.dart';

void main() => runApp(LoadingScreen());

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLogged = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: HomePage(userLogged),
          ),
        ),
      ),
    );
  }
  getSharedPreference() async {
    bool value = await SharedPref().getBoolValuesSF("user");
    setState(() {
      userLogged = value ;
    });
  }
  @override
  void initState() {
    getSharedPreference();
    // TODO: implement initState
    super.initState();
  }
}

class HomePage extends StatelessWidget {
  final bool userlogged;
  HomePage(this.userlogged);

  @override
  Widget build(BuildContext context) {
    return userlogged ?? false ? DataList() : LoginScreen();
  }
}

