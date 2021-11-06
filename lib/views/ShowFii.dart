import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:Fiinance/Service/StatusInvestApi.dart';
import 'package:Fiinance/Sidebar.dart';
import 'package:Fiinance/State/Controller.dart';
import 'package:Fiinance/components/Dialog.dart';
import 'package:Fiinance/components/Header.dart';
import 'package:Fiinance/components/HiddenValue.dart';
import 'package:Fiinance/views/EditFii.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

class ShowFii extends StatefulWidget {
  final stock;
  const ShowFii({Key key, this.stock}) : super(key: key);

  @override
  _ShowFiiState createState() => _ShowFiiState();
}

class _ShowFiiState extends State<ShowFii> {
  final Controller controller = Get.put(Controller());
  bool isLoadingTrash = false;
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

  Widget floatDelete() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn2",
        onPressed: () async {
          try {
            setState(() {
              this.isLoadingTrash = true;
            });
            await controller.removeStock(widget.stock['id']);
            setState(() {
              this.isLoadingTrash = false;
            });
            Navigator.of(context).pop();
          } catch (e) {
            dialog(e, context);
          }
        },
        backgroundColor: Colors.red,
        tooltip: 'First button',
        child: isLoadingTrash
            ? SizedBox(
                height: 24.0, width: 24.0, child: CircularProgressIndicator())
            : Icon(Icons.delete),
      ),
    );
  }

  Widget floatEdit() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Sidebar(
                component: EditFii(stock: widget.stock),
              ),
            ),
          );
        },
        tooltip: 'Second button',
        child: Icon(Icons.edit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          header(),
          Container(
            padding: EdgeInsets.all(20),
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
                            "Valor do Ativo",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          GetBuilder<Controller>(
                            builder: (_) => controller.isVisible
                                ? Text(
                                    "R\$ " + widget.stock['price'],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  )
                                : hiddenValue(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "DY",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "(12 meses)",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
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
                                  builder: (_) => controller.isVisible
                                      ? Text(
                                          snapshot.data + '%',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : hiddenValue(),
                                );
                              }
                            },
                          ),
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
                              child: controller.isVisible
                                  ? Text(
                                      "R\$ " + this.valueApplied(),
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    )
                                  : hiddenValue(),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Quantidade",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          GetBuilder<Controller>(
                            builder: (_) => controller.isVisible
                                ? Text(
                                    widget.stock['quantityStock'],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  )
                                : hiddenValue(),
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
              padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
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
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[floatDelete(), floatEdit()],
          colorStartAnimation: Color.fromRGBO(57, 181, 74, 1),
          colorEndAnimation: Color.fromRGBO(57, 181, 74, 1),
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
    );
  }
}
