import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/Sidebar.dart';
import 'package:wallet/State/Controller.dart';
import 'package:wallet/views/EditFii.dart';

class IndexFii extends StatefulWidget {
  const IndexFii({Key key}) : super(key: key);

  @override
  _IndexFiiState createState() => _IndexFiiState();
}

class _IndexFiiState extends State<IndexFii> {
  final controller = Get.put(Controller());
  var isLoading = {'isLoading': false, 'index': -1};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  "Meus FI's",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'ubuntu', fontSize: 25),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Seus Ativos",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'avenir'),
            ),
          ),
          Expanded(
            child: Container(
              child: GetBuilder<Controller>(
                builder: (_) => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemCount: controller.stocks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xfff1f3f6),
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.stocks[index]['code']),
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Sidebar(
                                            component: EditFii(
                                                stock:
                                                    controller.stocks[index]),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit,
                                        size: 26, color: Colors.blueGrey),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        this.isLoading['isLoading'] = true;
                                        this.isLoading['index'] = index;
                                      });
                                      await controller.removeStock(
                                          controller.stocks[index]['id']);
                                      setState(() {
                                        this.isLoading['isLoading'] = false;
                                        this.isLoading['index'] = -1;
                                      });
                                    },
                                    icon: this.isLoading['isLoading'] &&
                                            this.isLoading['index'] == index
                                        ? SizedBox(
                                            width: 26.0,
                                            height: 26.0,
                                            child: CircularProgressIndicator())
                                        : Icon(
                                            Icons.delete,
                                            size: 26,
                                            color: Colors.red,
                                          ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
