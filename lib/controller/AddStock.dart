import 'package:Fiinance/Service/StatusInvestApi.dart';

class AddStockController {
  static Future isFii(ticker) async {
    var response = await StatusInvestApi().searchStock(ticker);

    return response.length > 0 ? true : false;
  }
}
