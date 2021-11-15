import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/broker.dart';
import '../controllers/analysis.dart';

class Analysis extends StatelessWidget {
  const Analysis({Key? key, required this.broker}) : super(key: key);
  final Broker broker;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(broker.name.split(' ').take(2).join(' ') +
              ' ( Broker ${broker.code})'),
          bottom: TabBar(tabs: const [
            Tab(
              text: 'Buy',
            ),
            Tab(
              text: 'Sell',
            ),
          ]),
        ),
        body: GetBuilder<AnalysisController>(
          init: AnalysisController(broker),
          builder: (controller) {
            final buysheets = controller.analyzedbuysheets;
            final sellsheets = controller.analyzedsellsheets;
            return TabBarView(
              children: [
                controller.isBuyLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              row('Symbol', isBold: true),
                              row('Qty', isBold: true),
                              row('Qty %', isBold: true),
                              row('High', isBold: true),
                              row('Low', isBold: true),
                              row('Avg', isBold: true),
                              row('Amount', isBold: true),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (ctx, i) {
                                final sheet = buysheets[i];
                                return Container(
                                  color: i.isEven ? Colors.black12 : null,
                                  child: Row(
                                    children: [
                                      row(sheet.symbol),
                                      row(sheet.qty.toString(),
                                          color: Colors.green.shade500),
                                      row(sheet
                                          .percent(controller.totalBuyQty)),
                                      row(sheet.high.toString()),
                                      row(sheet.low.toString()),
                                      row(sheet.average),
                                      row(sheet.amount.truncate().toString()),
                                    ],
                                  ),
                                );
                              },
                              itemCount: buysheets.length,
                            ),
                          ),
                        ],
                      ),
                controller.isSellLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              row('Symbol', isBold: true),
                              row('Qty', isBold: true),
                              row('Qty %', isBold: true),
                              row('High', isBold: true),
                              row('Low', isBold: true),
                              row('Avg', isBold: true),
                              row('Amount', isBold: true),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (ctx, i) {
                                final sheet = sellsheets[i];
                                return Container(
                                  color: i.isEven ? Colors.black12 : null,
                                  child: Row(
                                    children: [
                                      row(sheet.symbol),
                                      row(sheet.qty.toString(),
                                          color: Colors.green.shade500),
                                      row(sheet
                                          .percent(controller.totalSellQty)),
                                      row(sheet.high.toString()),
                                      row(sheet.low.toString()),
                                      row(sheet.average),
                                      row(sheet.amount.truncate().toString()),
                                    ],
                                  ),
                                );
                              },
                              itemCount: sellsheets.length,
                            ),
                          ),
                        ],
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget row(String value, {int flex = 2, bool isBold = false, Color? color}) {
    return Flexible(
        flex: flex,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            value,
            maxLines: 1,
            textScaleFactor: 0.9,
            style: isBold
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(color: color),
          ),
        ));
  }
}
