import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wallet/components/HiddenValue.dart';

double number(String string) {
  return double.parse(string);
}

Widget cardFii(stock, isVisible) {
  var date = Jiffy(stock['dividends']['pd'], "dd/MM/yyyy");
  var total = '0';
  var dividend = '0,00';
  int difference;
  if (date.month == Jiffy().month) {
    var value = stock['dividends']['v'];

    var f = NumberFormat("#,##0.00", "pt");
    dividend = f.format(value);
    total = f.format(double.parse(stock['quantityStock']) * value);
    difference =
        DateTime.parse(date.format()).difference(DateTime.now()).inDays;
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
                "Rendimento: R\$ $dividend",
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
              width: 85.0,
              alignment: Alignment.center,
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
                  color: difference != null && difference < 0
                      ? Colors.green
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                      width: 2.0,
                      color: difference != null && difference < 0
                          ? Colors.green
                          : Colors.black38)),
              child: Text(
                difference != null
                    ? difference < 0
                        ? 'Recebeu'
                        : "daqui $difference dias"
                    : 'Sem divulgação',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: difference != null && difference < 0
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
