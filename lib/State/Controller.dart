import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class Controller extends GetxController {
  var count = 0;
  var username = '';
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
}
