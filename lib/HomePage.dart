import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallet/State/Controller.dart';
import 'package:wallet/components/AskName.dart';
import 'package:wallet/components/CardFii.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallet/components/SummaryWallet.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        controller.updateSummary();
      }),
    );
    getApplicationDocumentsDirectory().then((Directory directory) {
      Directory dir = directory;
      File jsonFile = new File(dir.path + "/" + controller.fileName);
      var user = jsonDecode(jsonFile.readAsStringSync());
      bool fileExists = jsonFile.existsSync();
      if (!fileExists || user['username'] == null) {
        SchedulerBinding.instance
            .addPostFrameCallback((_) => exibirDialogo(context, controller));
      }
    });
    super.initState();
    // TODO: implement initState
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          GetBuilder<Controller>(
            builder: (_) =>
                summaryWallet(controller, controller.mySummaryLoading),
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
                    child: GetBuilder<Controller>(
                      builder: (controller) => controller.myFiiLoading
                          ? Center(child: CircularProgressIndicator())
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
                                          builder: (context) => ShowFii(
                                              stock: controller.stocks[index]),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: cardFii(controller.stocks[index],
                                          controller.isVisible),
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
