import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wallet/State/Controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return homePage();
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final controller = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30, left: 20, bottom: 0, right: 30),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('asset/images/logo.png'),
                    )),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "eWalle",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'ubuntu',
                        fontSize: 25),
                  )
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, bottom: 20, top: 20.0, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Resumo da Carteira no mês",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'avenir'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xfff1f3f6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rendimento",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "R\$ 100",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "DY",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "8,6%",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Valor Investido",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "R\$ 20.600",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Rentabilidade",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "3%",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, bottom: 20, right: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Seus FII's",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'avenir'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Container(
                          height: 300.0,
                          child: GetBuilder<Controller>(
                            builder: (_) => ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              itemCount: controller.stocks.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: cardFii(controller.stocks[index]),
                                );
                              },
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  double number(String string) {
    return double.parse(string);
  }

  Widget cardFii(stock) {
    var date = Jiffy(stock['dividends']['pd'], "dd/MM/yyyy");
    var total = '0';
    var dividend = '0,00';
    var difference = '';
    if (date.month == Jiffy().month) {
      var value = stock['dividends']['v'];

      var f = NumberFormat("#,##0.00", "pt");
      dividend = f.format(value);
      total = f.format(this.number(stock['quantityStock']) * value);
      difference = DateTime.parse(date.format())
          .difference(DateTime.now())
          .inDays
          .toString();
    }

    return Container(
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.only(bottom: 10),
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
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "R\$ $total",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: 5.0, top: 5.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    color:
                        difference == '0' ? Colors.green : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                        width: 3.0,
                        color:
                            difference == '0' ? Colors.green : Colors.black38)),
                child: Text(
                  difference != ''
                      ? difference == '0'
                          ? 'Recebe hoje'
                          : "daqui $difference dias"
                      : 'Sem divulgação',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: difference == '0' ? Colors.white : Colors.black38),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
