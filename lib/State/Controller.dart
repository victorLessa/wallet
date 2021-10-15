import 'dart:convert';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallet/Service/StatusInvestApi.dart';

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
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) {
        var saveUser = jsonDecode(jsonFile.readAsStringSync());
        this.stocks = await StatusInvestApi().lastDividends(saveUser['stocks']);
        username = saveUser['username'];
        update();
      }
    });
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

  void addStock(data) async {
    if (!fileExists) {
      this.createFile({});
    }
    var lastDividend = await StatusInvestApi().searchLastDividend(data['code']);
    data['dividends'] = lastDividend;
    this.stocks.add(data);
    var saveUser = jsonDecode(jsonFile.readAsStringSync());
    saveUser['stocks'] = this.stocks;
    jsonFile.writeAsStringSync(jsonEncode(saveUser));
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
