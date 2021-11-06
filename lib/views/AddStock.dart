import 'dart:async';

import 'package:Fiinance/controller/AddStock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:Fiinance/Service/StatusInvestApi.dart';
import 'package:Fiinance/State/Controller.dart';
import 'package:Fiinance/components/Header.dart';

class AddStock extends StatefulWidget {
  const AddStock({Key key}) : super(key: key);

  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  Controller controller = Get.put(Controller());
  final quantityStockController = TextEditingController();
  final typeAheadFieldController = TextEditingController();
  var formData = new Map();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            header(),
            SizedBox(height: 10.0),
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
                  autocompleteSample(),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantidade de Ativos',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
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
                        this.formData["code"] = typeAheadFieldController.text;
                        if (this.formData['code'].length == 6) {
                          bool isFii = await AddStockController.isFii(
                              this.formData['code']);
                          if (isFii) {
                            bool has =
                                await controller.submitStock(this.formData);
                            if (has) {
                              dialog('Ativo já faz parte da sua carteira.',
                                  'warning');
                            } else {
                              dialog(
                                  "Ativo adicionado a sua carteira com sucesso.",
                                  'success');
                            }
                          } else {
                            dialog(
                                "Favor selecione um Fundo Imobiliários válido.",
                                'error');
                          }
                        } else {
                          dialog(
                              "Favor selecione um Fundo Imobiliários válido.",
                              'error');
                        }
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

  Widget autocompleteSample() {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: typeAheadFieldController,
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontStyle: FontStyle.italic),
          decoration: InputDecoration(
              labelText: 'Nome do Ativo',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)))),
      suggestionsCallback: (pattern) async {
        return await StatusInvestApi().searchStock(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion['code']),
        );
      },
      onSuggestionSelected: (suggestion) {
        typeAheadFieldController.text = suggestion['code'];
        this.formData = suggestion;
      },
    );
  }

  Widget renderIcon(icon, color) {
    return CircleAvatar(
      maxRadius: 30.0,
      backgroundColor: Colors.black12,
      child: Icon(icon, color: color, size: 40.0),
    );
  }

  wrapIconDialog(String type) {
    switch (type) {
      case 'error':
        return this.renderIcon(Icons.error, Colors.red);
        break;
      case 'success':
        return this.renderIcon(Icons.check, Colors.green);
        break;
      case 'warning':
        return this.renderIcon(Icons.warning, Colors.orange);
        break;
      default:
        return this.renderIcon(Icons.check, Colors.green);
        break;
    }
  }

  void dialog(String text, type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: this.wrapIconDialog(type),
          content: Text(text, textAlign: TextAlign.center),
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
}
