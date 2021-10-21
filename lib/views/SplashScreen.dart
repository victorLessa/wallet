import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wallet/HomePage.dart';
import 'package:wallet/Sidebar.dart';
import 'package:wallet/State/Controller.dart';
import 'package:wallet/views/Intro.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Controller controller = Get.put(Controller());

  Future<Widget> loadFromFuture() async {
    // <fetch data from server. ex. login>
    Directory dir = await getApplicationDocumentsDirectory();

    File jsonFile = new File(dir.path + "/" + controller.fileName);
    bool fileExists = jsonFile.existsSync();
    if (fileExists) {
      var user = jsonDecode(jsonFile.readAsStringSync());
      if (user['skipIntro'] != null) {
        return Future.value(new Intro());
      }
      return Future.value(new Sidebar(component: HomePage()));
    } else {
      return Future.value(new Intro());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterFuture:
          Future.delayed(Duration(seconds: 4), () => loadFromFuture()),
      title: new Text(
        'Bem vindo ao Meus Fundos Imobiliários',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }
}
