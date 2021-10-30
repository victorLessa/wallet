import 'dart:convert';
import 'dart:io';

import 'package:fiinance/HomePage.dart';
import 'package:fiinance/Sidebar.dart';
import 'package:fiinance/State/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
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
    return SplashScreen(
      seconds: 6,
      navigateAfterFuture:
          Future.delayed(Duration(seconds: 4), () => loadFromFuture()),
      title: new Text(
        'Bem vindo ao FIInances',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      useLoader: false,
    );
  }
}
