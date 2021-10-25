import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget header() {
  return Container(
    padding: EdgeInsets.only(top: 30, left: 20, bottom: 0, right: 30),
    child: Row(
      children: [
        Container(
          width: 150,
          height: 50,
          alignment: Alignment.centerLeft,
          child: Text(
            "Meus FII's",
            style: TextStyle(
                color: Colors.black, fontFamily: 'ubuntu', fontSize: 25),
          ),
        ),
      ],
    ),
  );
}
