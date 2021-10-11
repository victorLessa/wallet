import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class Controller extends GetxController {
  var count = 0;
  var nameUser = '';
  File jsonFile;
  Directory dir;
  String fileName = "save_user.json";
  bool fileExists = false;
  Map<String, String> fileContent;
  void increment() {
    count++;
    update();
  }

  void setNameUser(name) {
        getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      print(directory);
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        fileContent = jsonDecode(jsonFile.readAsStringSync());
    });
    nameUser = name;
    update();
  }
}