import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:Fiinance/components/HiddenValue.dart';

double number(String string) {
  return double.parse(string);
}

Widget cardFii(stock, isVisible) {
  var total = '0';
  var dividendValue = '0,00';
  int difference = 0;
  bool currentMonth = false;
  for (var dividend in stock['dividends']) {
    var date = Jiffy(dividend['pd'], 'dd/MM/yyyy');
    if (date.year == Jiffy().year && date.month == Jiffy().month) {
      var value = dividend['v'];
      currentMonth = true;
      var f = NumberFormat("#,##0.00", "pt");
      dividendValue = f.format(value);
      total = f.format(double.parse(stock['quantityStock']) * value);
      var inDays =
          DateTime.parse(date.format()).difference(DateTime.now()).inDays;
      if (inDays > 0) difference = inDays;
    }
  }

  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Color(0xfff1f3f6),
    ),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock['code'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Rendimento: R\$ $dividendValue",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 20.0,
              alignment: Alignment.centerRight,
              child: isVisible
                  ? Text(
                      "R\$ $total",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    )
                  : hiddenValue(),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: 5.0, top: 5.0, left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  color: currentMonth && difference <= 0
                      ? Color.fromRGBO(57, 181, 74, 1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                      width: 2.0,
                      color: currentMonth && difference <= 0
                          ? Color.fromRGBO(57, 181, 74, 1)
                          : Colors.black38)),
              child: Text(
                currentMonth
                    ? difference <= 0
                        ? 'Recebeu'
                        : "daqui $difference dias"
                    : 'Sem divulgação',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: currentMonth && difference <= 0
                        ? Colors.white
                        : difference == null
                            ? Colors.black38
                            : Colors.black),
              ),
            )
          ],
        ))
      ],
    ),
  );
}
