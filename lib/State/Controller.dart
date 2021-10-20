import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallet/Service/StatusInvestApi.dart';

class Controller extends GetxController {
  var count = 0;
  var username = '';
  List stocks = [];
  File jsonFile;
  Directory dir;
  String fileName = "saveUser.json";
  bool fileExists = false;
  bool myFiiLoading = true;
  var totalPatrimony = '0';
  var totalYield = '0';
  var profitability = '0';
  var dY = '0';
  var fileContent;
  var currentDy = '';

  @override
  void onInit() {
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) {
        var saveUser = jsonDecode(jsonFile.readAsStringSync());
        fileContent = saveUser;
        await this.updateSummary();
        this.myFiiLoading = false;
        username = saveUser['username'];
        update();
      } else {
        this.createFile({});
      }
    });
    super.onInit();
  }

  Future updateSummary() async {
    if (this.fileContent != null && this.fileContent['stocks'].length > 0) {
      this.myFiiLoading = true;
      var f = NumberFormat("#,##0.00", "pt");
      this.stocks = await this.getLastDividends(this.fileContent['stocks']);
      var total = await this.fethTotalPatrimony(this.fileContent['stocks']);
      var totalYield = this.fetchTotalYield(this.fileContent['stocks']);

      this.profitability = await this.fetchProfitability();
      this.totalPatrimony = f.format(total);
      this.totalYield = f.format(totalYield);
      this.dY = f.format(this.fetchYield(total, totalYield));
      this.myFiiLoading = false;
      update();
    } else {
      var f = NumberFormat("#,##0.00", "pt");
      this.totalPatrimony = f.format(0);
      this.totalYield = f.format(0);
      this.dY = f.format(0);
      this.profitability = f.format(0) + '%';
      update();
    }
  }

  Future<List> getLastDividends(stocks) async {
    List result = [];
    for (var stock in stocks) {
      var response = await StatusInvestApi().lastDividends(stock['code']);
      stock['dividends'] = response.data['assetEarningsModels'][0];
      result.add(stock);
    }

    return result;
  }

  createFile(Map<String, String> content) {
    File jsonFile = new File(dir.path + "/" + fileName);
    jsonFile.createSync();
    fileExists = true;
    jsonFile.writeAsStringSync(jsonEncode(content));
    this.fileContent = content;
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

  Future addStock(data) async {
    if (!fileExists) {
      this.createFile({});
    }
    var lastDividend = await StatusInvestApi().searchLastDividend(data['code']);
    data['dividends'] = lastDividend;
    this.stocks.add(data);
    var saveUser = jsonDecode(jsonFile.readAsStringSync());
    saveUser['stocks'] = this.stocks;
    this.fileContent['stocks'] = this.stocks;
    jsonFile.writeAsStringSync(jsonEncode(saveUser));
    update();
  }

  Future submitStock(data) async {
    var has = this.stocks.where((element) => element['code'] == data['code']);
    if (has.length == 0) {
      await this.addStock(data);
    } else {
      return true;
    }
    return false;
  }

  Future removeStock(id) async {
    List newStock = [];
    for (var stock in this.stocks) {
      if (stock['id'] != id) {
        newStock.add(stock);
      }
    }
    this.stocks = newStock;
    if (this.fileContent.length >= 0) {
      this.fileContent['stocks'] = this.stocks;
    }
    jsonFile.writeAsStringSync(jsonEncode(this.fileContent));
    update();
  }

// Resumo da carteira

  double fetchTotalYield(stocks) {
    double total = 0;
    for (var stock in stocks) {
      total += stock['dividends']['v'] * double.parse(stock['quantityStock']);
    }

    return total;
  }

  Future<double> fethTotalPatrimony(stocks) async {
    double total = 0;

    for (var stock in stocks) {
      var response = await StatusInvestApi().searchStock(stock['code']);
      var price = double.parse(
          response[0]['price'].replaceAll('.', '').replaceAll(',', '.'));
      total += price * double.parse(stock['quantityStock']);
    }

    return total;
  }

  double fetchYield(total, totalYield) {
    var result = (totalYield * 100) / total;

    if (result.isNaN)
      return 0;
    else
      return result;
  }

  fetchProfitability() async {
    double startValue = 0;
    double endValue = 0;
    for (var stock in this.stocks) {
      var profitability =
          await StatusInvestApi().fetchProfitability(stock['code']);

      startValue += profitability[0]['prices'][0]['price'];
      endValue += profitability[0]['prices']
          [profitability[0]['prices'].length - 1]['price'];
    }

    var percentage = (endValue * 100) / startValue;

    var f = NumberFormat("#,##0.00", "pt");

    if (percentage.isNaN) {
      return '0%';
    } else if (percentage < 100) {
      return f.format(100 - percentage) + '%';
    } else {
      return f.format(percentage - 100) + '%';
    }
  }
}
