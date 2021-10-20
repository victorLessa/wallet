import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/Sidebar.dart';
import 'package:wallet/State/Controller.dart';
import 'package:wallet/components/CardFii.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallet/views/ShowFii.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          controller.updateSummary();
        }));
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
              children: <Widget>[
                Text(
                  "Resumo da Carteira",
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
                            "Rendimento (mês)",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          GetBuilder<Controller>(
                            builder: (_) => Text(
                              "R\$ " + controller.totalYield,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "DY (mês)",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          GetBuilder<Controller>(
                            builder: (_) => Text(
                              controller.dY,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
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
                          GetBuilder<Controller>(
                            builder: (_) => Container(
                              child: Text(
                                "R\$ " + controller.totalPatrimony,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Rentabilidade",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              GetBuilder<Controller>(
                                builder: (_) => Text(
                                  controller.profitability,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Semana')
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
                        "Seus FII's",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'avenir'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/editFiis');
                        },
                        child: Row(
                          children: [
                            Text(
                              'Editar',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(Icons.edit)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: GetBuilder<Controller>(
                      builder: (controller) => controller.myFiiLoading
                          ? Center(
                              child: SpinKitFadingCircle(
                                color: Colors.blueGrey,
                              ),
                            )
                          : Container(
                              height: 300.0,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                itemCount: controller.stocks.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Sidebar(
                                            component: ShowFii(
                                                stock:
                                                    controller.stocks[index]),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: cardFii(controller.stocks[index]),
                                    ),
                                  );
                                },
                              ),
                            ),
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
