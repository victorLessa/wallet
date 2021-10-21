import 'package:flutter/material.dart';
import 'package:wallet/routes/Paths.dart';
import 'package:wallet/views/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/homePage',
      routes: RoutePaths().paths(),
      home: SplashScreenPage(),
    );
  }
}
