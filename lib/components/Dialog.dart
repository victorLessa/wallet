import 'package:flutter/material.dart';

void dialog(String text, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: Text(text, textAlign: TextAlign.center),
        actions: [
          SizedBox(
              width: double.maxFinite,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text('Fechar'),
              ))
        ],
      );
    },
  );
}
