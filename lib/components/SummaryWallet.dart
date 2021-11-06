import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Fiinance/State/Controller.dart';
import 'package:Fiinance/components/HiddenValue.dart';

Widget summaryFiinance(Controller controller, bool isLoadingSummary) {
  return Container(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Resumo da Carteira",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'avenir'),
            ),
            IconButton(
                onPressed: () async {
                  await controller.updateSummary();
                },
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(Icons.refresh, color: Colors.blueGrey))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xfff1f3f6),
          ),
          child: isLoadingSummary
              ? Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rendimento (mês)",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        GetBuilder<Controller>(
                          builder: (_) => controller.isVisible
                              ? Text(
                                  "R\$ " + controller.totalYield,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                )
                              : hiddenValue(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "DY (mês)",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        GetBuilder<Controller>(
                          builder: (_) => controller.isVisible
                              ? Text(
                                  controller.dY + '%',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                )
                              : hiddenValue(),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Valor Investido",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Wrap(
                          children: [
                            GetBuilder<Controller>(
                              builder: (_) => controller.isVisible
                                  ? Text(
                                      "R\$ " + controller.totalPatrimony,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    )
                                  : hiddenValue(),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Rentabilidade",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GetBuilder<Controller>(
                              builder: (_) => controller.isVisible
                                  ? Text(
                                      controller.profitability,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    )
                                  : hiddenValue(),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Semana')
                          ],
                        )
                      ],
                    )
                  ],
                ),
        ),
      ],
    ),
  );
}
