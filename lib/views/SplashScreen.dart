import 'package:Fiinance/HomePage.dart';
import 'package:Fiinance/Sidebar.dart';
import 'package:Fiinance/State/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Controller controller = Get.put(Controller());

  Future<Widget> loadFromFuture() async {
    // <fetch data from server. ex. login>

    return Future.value(new Sidebar(component: HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SplashScreen(
            navigateAfterFuture:
                Future.delayed(Duration(seconds: 4), () => loadFromFuture()),
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 150.0,
            useLoader: false,
          ),
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'asset/images/LogoSplashScreen.png',
                    width: 200.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
