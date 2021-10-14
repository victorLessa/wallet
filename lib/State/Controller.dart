import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0;
  var username = '';
  List stocks = [];
  File jsonFile;
  Directory dir;
  String fileName = "saveUsers.json";
  bool fileExists = false;
  Map<String, String> fileContent;

  @override
  void onInit() {
    super.onInit();
  }

  createFile(Map<String, String> content) {
    File jsonFile = new File(dir.path + "/" + fileName);
    jsonFile.createSync();
    fileExists = true;
    jsonFile.writeAsStringSync(jsonEncode(content));
  }

  void increment() {
    count++;
    update();
  }

  void setNameUser(name) {
    if (!fileExists) {
      this.createFile({});
    }
    var saveUser = jsonDecode(jsonFile.readAsStringSync());
    saveUser['username'] = name;
    jsonFile.writeAsStringSync(jsonEncode(saveUser));
    this.username = name;
    update();
  }

  void addStock(data) {
    this.stocks.add(data);
    update();
  }

  bool submitStock(data) {
    var has = this.stocks.where((element) => element['code'] == data['code']);
    if (has.length == 0) {
      this.addStock(data);
    } else {
      return true;
    }
    return false;
  }
}
