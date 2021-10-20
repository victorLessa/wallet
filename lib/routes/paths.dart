import 'package:wallet/HomePage.dart';
import 'package:wallet/Sidebar.dart';
import 'package:wallet/views/AddStock.dart';
import 'package:wallet/views/EditFii.dart';

class RoutePaths {
  paths() {
    return {
      '/homePage': (context) => Sidebar(component: homePage()),
      '/addStock': (context) => Sidebar(component: AddStock()),
      '/editFiis': (context) => Sidebar(component: EditFii())
    };
  }
}
