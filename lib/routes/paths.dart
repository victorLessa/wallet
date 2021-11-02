import 'package:Fiinance/HomePage.dart';
import 'package:Fiinance/Sidebar.dart';
import 'package:Fiinance/views/AddStock.dart';
import 'package:Fiinance/views/Quotes.dart';

class RoutePaths {
  paths() {
    return {
      '/homePage': (context) => Sidebar(component: homePage()),
      '/addStock': (context) => Sidebar(component: AddStock()),
      '/quotes': (context) => Sidebar(component: Quotes())
    };
  }
}
