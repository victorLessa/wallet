import 'package:wallet/HomePage.dart';
import 'package:wallet/Sidebar.dart';
import 'package:wallet/views/AddStock.dart';
import 'package:wallet/views/Projections.dart';

class RoutePaths {
  paths() {
    return {
      '/homePage': (context) => Sidebar(component: homePage()),
      '/projections': (context) => Sidebar(component: Projections()),
      '/addStock': (context) => Sidebar(component: AddStock())
    };
  }
}
