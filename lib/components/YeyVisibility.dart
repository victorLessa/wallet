import 'package:flutter/material.dart';

Widget yeyVisibility(controller) {
  return controller.isVisible
      ? IconButton(
          padding: EdgeInsets.only(top: 15),
          onPressed: () {
            controller.visibility(!controller.isVisible);
          },
          icon: Icon(Icons.visibility, size: 30, color: Colors.indigo),
        )
      : IconButton(
          padding: EdgeInsets.only(top: 15),
          onPressed: () {
            controller.visibility(!controller.isVisible);
          },
          icon: Icon(Icons.visibility_off, size: 30, color: Colors.indigo),
        );
}
