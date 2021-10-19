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
  String fileName = "saveUsers.json";
  bool fileExists = false;
  var totalPatrimony = '0';
  var totalYield = '0';
  var profitability = '0';
  var dY = '0';
  Map<String, String> fileContent;

  @override
  void onInit() {
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) {
        var saveUser = jsonDecode(jsonFile.readAsStringSync());
        this.stocks = await this.getLastDividends(saveUser['stocks']);
        var total = await this.fethTotalPatrimony(saveUser['stocks']);
        var totalYield = this.fetchTotalYield(saveUser['stocks']);
        await this.fetchProfitability();
        var f = NumberFormat("#,##0.00", "pt");

        this.totalPatrimony = f.format(total);
        this.totalYield = f.format(totalYield);
        this.dY = f.format(this.fetchYield(total, totalYield));
        username = saveUser['username'];
        update();
      }
    });
    super.onInit();
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
    return (totalYield * 100) / total;
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

    if (percentage < 100) {
      this.profitability = f.format(100 - percentage) + '%';
    } else {
      this.profitability = f.format(percentage - 100) + '%';
    }
  }
}
