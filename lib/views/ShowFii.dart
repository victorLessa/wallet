import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet/Service/StatusInvestApi.dart';
import 'package:wallet/Sidebar.dart';
import 'package:wallet/State/Controller.dart';

class ShowFii extends StatefulWidget {
  final stock;
  const ShowFii({Key key, this.stock}) : super(key: key);

  @override
  _ShowFiiState createState() => _ShowFiiState();
}

class _ShowFiiState extends State<ShowFii> {
  final Controller controller = Get.put(Controller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String valueApplied() {
    var f = NumberFormat("#,##0.00", "pt");

    var price = double.parse(
        widget.stock['price'].replaceAll('.', '').replaceAll(',', '.'));
    var total = price * double.parse(widget.stock['quantityStock']);

    return f.format(total);
  }

  @override
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
                      color: Colors.black, fontFamily: 'ubuntu', fontSize: 25),
                )
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(left: 20, bottom: 20, top: 20.0, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Resumo do ativo: " + widget.stock['code'],
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
                            "Valor",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          GetBuilder<Controller>(
                            builder: (_) => Text(
                              controller.isVisible
                                  ? "R\$ " + widget.stock['price']
                                  : '****',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "DY (12 meses)",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          FutureBuilder(
                            future:
                                StatusInvestApi().fetchDy(widget.stock['url']),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Text('Carregando...');
                              } else {
                                return GetBuilder<Controller>(
                                  builder: (_) => Text(
                                    controller.isVisible
                                        ? snapshot.data + '%'
                                        : '****',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Valor Aplicado",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          GetBuilder<Controller>(
                            builder: (_) => Container(
                              child: Text(
                                controller.isVisible
                                    ? "R\$ " + this.valueApplied()
                                    : '****',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Quantidade",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              GetBuilder<Controller>(
                                builder: (_) => Text(
                                  controller.isVisible
                                      ? widget.stock['quantityStock']
                                      : '****',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          )
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
                        "Proventos pagos",
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
                    child: FutureBuilder(
                      future:
                          StatusInvestApi().lastDividends(widget.stock['code']),
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SpinKitFadingCircle(
                              color: Colors.blueGrey,
                            ),
                          );
                        } else {
                          var dividends =
                              snapshot.data.data['assetEarningsModels'];
                          var f = NumberFormat("#,##0.00", "pt");

                          return Container(
                            height: 300.0,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              itemCount: dividends.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Container(
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color(0xfff1f3f6),
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Data: ' + dividends[index]['pd']),
                                        GetBuilder<Controller>(
                                          builder: (_) => Text(
                                            'Valor: R\$ ' +
                                                f.format(dividends[index]['v']),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
