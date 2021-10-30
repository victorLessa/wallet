import 'package:fiinance/HomePage.dart';
import 'package:fiinance/Sidebar.dart';
import 'package:fiinance/views/AddStock.dart';
import 'package:fiinance/views/Quotes.dart';

class RoutePaths {
  paths() {
    return {
      '/homePage': (context) => Sidebar(component: homePage()),
      '/addStock': (context) => Sidebar(component: AddStock()),
      '/quotes': (context) => Sidebar(component: Quotes())
    };
  }
}
