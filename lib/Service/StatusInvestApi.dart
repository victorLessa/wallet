import 'dart:convert';

import 'package:dio/dio.dart';

class StatusInvestApi {
  Future<Response> http(ticket) async {
    var response = await Dio().get(
        'https://statusinvest.com.br/home/mainsearchquery?q=$ticket&country=');
    return response;
  }

  searchStock(ticket) async {
    var response = await this.http(ticket);
    return response.data;
    // .map((key, value) => value["nameFormated"]);
  }
}
