import 'dart:convert';

import 'package:dio/dio.dart';

class StatusInvestApi {
  Future<Response> http(String url) async {
    var response = await Dio().get(url);
    return response;
  }

  searchStock(ticket) async {
    var response = await this.http(
        'https://statusinvest.com.br/home/mainsearchquery?q=$ticket&country=');
    return response.data;
    // .map((key, value) => value["nameFormated"]);
  }

  Future searchLastDividend(String ticker) async {
    var response = await this.http(
        'https://statusinvest.com.br/acao/companytickerprovents?ticker=$ticker&chartProventsType=0');
    return response.data['assetEarningsModels'][0];
  }

  Future lastDividends(stocks) async {
    List result = [];
    for (var stock in stocks) {
      var ticker = stock['code'];
      var response = await this.http(
          'https://statusinvest.com.br/acao/companytickerprovents?ticker=$ticker&chartProventsType=0');
      stock['dividends'] = response.data['assetEarningsModels'][0];
      result.add(stock);
    }
    return result;
  }
}
