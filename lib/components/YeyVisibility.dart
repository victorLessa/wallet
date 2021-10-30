import 'package:flutter/material.dart';

Widget yeyVisibility(controller) {
  return controller.isVisible
      ? IconButton(
          onPressed: () {
            controller.visibility(!controller.isVisible);
          },
          icon:
              Icon(Icons.visibility_outlined, size: 25, color: Colors.blueGrey),
        )
      : IconButton(
          onPressed: () {
            controller.visibility(!controller.isVisible);
          },
          icon: Icon(Icons.visibility_off_outlined,
              size: 25, color: Colors.blueGrey),
        );
}
