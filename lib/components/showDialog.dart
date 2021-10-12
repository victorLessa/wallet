import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void exibirDialogo(context, controller) {
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
