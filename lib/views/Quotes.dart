import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/Service/StatusInvestApi.dart';
import 'package:wallet/State/Controller.dart';

class Quotes extends StatefulWidget {
  const Quotes({Key key}) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, left: 20, bottom: 10, right: 30),
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
          Text(
            'Suas Cotações',
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                fontFamily: 'avenir'),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: FutureBuilder(
                future: StatusInvestApi().fetchQuotes(controller.stocks),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data[index];
                        double variation = double.parse(
                          data['variation']
                              .replaceAll('.', '')
                              .replaceAll(',', '.'),
                        );
                        return ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xfff1f3f6),
                            ),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data['code']),
                                Row(
                                  children: [
                                    Text('R\$ ' + data['price']),
                                    variation < 0
                                        ? Icon(Icons.arrow_drop_down_sharp,
                                            color: Colors.red)
                                        : Icon(Icons.arrow_drop_up_sharp,
                                            color: Colors.green),
                                    Text(
                                      data['variation'] + '%',
                                      style: TextStyle(
                                          color: variation < 0
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
