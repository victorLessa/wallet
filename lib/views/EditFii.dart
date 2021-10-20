import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:wallet/State/Controller.dart';
import 'package:wallet/components/Dialog.dart';

class EditFii extends StatefulWidget {
  final stock;
  const EditFii({Key key, this.stock}) : super(key: key);

  @override
  _EditFiiState createState() => _EditFiiState();
}

class _EditFiiState extends State<EditFii> {
  Controller controller = Get.put(Controller());
  final quantityStockController = TextEditingController();
  final stockNameFieldController = TextEditingController();
  var formData = new Map();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    stockNameFieldController.text = widget.stock['code'];
    quantityStockController.text = widget.stock['quantityStock'];
  }

  @override
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
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adicione um ativo.",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'avenir'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  autocompleteSample(widget.stock),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Quantidade de Ativos',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      controller: quantityStockController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      onPressed: () async {
                        this.formData['quantityStock'] =
                            quantityStockController.text;

                        await controller.updateStock(
                            widget.stock['id'], this.formData);

                        dialog("Ativo atualizado com sucesso.", context);
                        _btnController.success();
                        Timer(Duration(seconds: 1), () {
                          _btnController.reset();
                        });
                      },
                      child: Text('Adicionar'),
                    ),
                  )
                ],
              ),
            ))
          ],
        ));
  }

  Widget autocompleteSample(stock) {
    return TextField(
      controller: stockNameFieldController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Nome do Ativo',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      readOnly: true,
    );
  }
}
