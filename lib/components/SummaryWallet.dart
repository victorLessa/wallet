import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/State/Controller.dart';
import 'package:wallet/components/HiddenValue.dart';

Widget summaryWallet(Controller controller, bool isLoadingSummary) {
  return Container(
    padding: EdgeInsets.only(left: 20, bottom: 20, top: 20.0, right: 30),
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
          height: 160.0,
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
                        Container(
                          height: 20.0,
                          child: GetBuilder<Controller>(
                            builder: (_) => controller.isVisible
                                ? Text(
                                    "R\$ " + controller.totalYield,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  )
                                : hiddenValue(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "DY (mês)",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Container(
                          height: 20.0,
                          child: GetBuilder<Controller>(
                            builder: (_) => controller.isVisible
                                ? Text(
                                    controller.dY + '%',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  )
                                : hiddenValue(),
                          ),
                        )
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
                            Container(
                              height: 20.0,
                              width: 120.0,
                              alignment: Alignment.centerLeft,
                              child: GetBuilder<Controller>(
                                builder: (_) => controller.isVisible
                                    ? Text(
                                        "R\$ " + controller.totalPatrimony,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      )
                                    : hiddenValue(),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Rentabilidade",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20.0,
                              child: GetBuilder<Controller>(
                                builder: (_) => controller.isVisible
                                    ? Text(
                                        controller.profitability,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      )
                                    : hiddenValue(),
                              ),
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
