import 'package:web_scraper/web_scraper.dart';
import 'package:dio/dio.dart';

class StatusInvestApi {
  final searchTicker = 'https://statusinvest.com.br/home/mainsearchquery';
  Future<Response> get(String url) async {
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> post(String url, data) async {
    var response = await Dio().post(url, data: data);
    return response;
  }

  Future<List> searchStock(ticket) async {
    var response = await this.get('$searchTicker?q=$ticket&country=');
    return response.data.where((element) => element['type'] == 2).toList();
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

  Future<String> fetchDy(String uri) async {
    final webScraper = WebScraper('https://statusinvest.com.br');
    if (await webScraper.loadWebPage(uri)) {
      List<Map<String, dynamic>> elements = webScraper.getElement(
          '[title="Dividend Yield com base nos últimos 12 meses"] > strong.value',
          []);
      return elements[0]['title'];
    }
    return '0';
  }
}
