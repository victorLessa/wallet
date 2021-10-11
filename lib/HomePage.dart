import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
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

    if (controller.nameUser == '') {
      print('inicio');
      SchedulerBinding.instance
          .addPostFrameCallback((_) => _exibirDialogo(context, controller));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 30, left: 20, bottom: 10, right: 30),
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
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
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
                    SizedBox(
                      height: 20,
                    ),
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
                      height: 10,
                    ),
                    fiiWidget("avatar1", "Mike"),
                    fiiWidget("avatar1", "Mike"),
                    fiiWidget("avatar1", "Mike"),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Container fiiWidget(String img, String name) {
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
                  "BCFF11",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Rendimento: 0,50",
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
                "R\$ 20,00",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: 5.0, top: 5.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(width: 3.0, color: Colors.black38)),
                child: Text(
                  "daqui 5 dias",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

void _exibirDialogo(context, controller) {
  final textController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title:
            new Text("Me informe o nome pelo qual você quer ser chamado. :)"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            onPressed: () {
              controller.setNameUser(textController.text);
              Navigator.pop(context, true);
            },
            child: Text('Continuar'),
          )
        ],
      );
    },
  );
}
