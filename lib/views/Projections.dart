import 'package:flutter/material.dart';

class Projections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _projections();
  }
}

class _projections extends StatelessWidget {
  const _projections({Key key}) : super(key: key);

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
                "Projeções",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'ubuntu', fontSize: 25),
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Provável ganho até o final do ano.",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'avenir'),
                  ),
                ],
              )),
        )
      ],
    ));
  }
}
