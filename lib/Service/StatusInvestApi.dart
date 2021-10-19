import 'dart:convert';

import 'package:dio/dio.dart';

class StatusInvestApi {
  Future<Response> get(String url) async {
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> post(String url, data) async {
    var response = await Dio().post(url, data: data);
    return response;
  }

  searchStock(ticket) async {
    var response = await this.get(
        'https://statusinvest.com.br/home/mainsearchquery?q=$ticket&country=');
    return response.data;
    // .map((key, value) => value["nameFormated"]);
  }

  Future searchLastDividend(String ticker) async {
    var response = await this.get(
        'https://statusinvest.com.br/acao/companytickerprovents?ticker=$ticker&chartProventsType=0');
    return response.data['assetEarningsModels'][0];
  }

  Future lastDividends(ticket) async {
    var response = await this.get(
        'https://statusinvest.com.br/acao/companytickerprovents?ticker=$ticket&chartProventsType=0');

    return response;
  }

  Future fetchProfitability(ticker) async {
    FormData formData =
        FormData.fromMap({"ticker": ticker, "type": 0, "currencies": '1'});
    var response = await this
        .post('https://statusinvest.com.br/fii/tickerprice', formData);
    return response.data;
  }
}
