import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/analysis.dart';
import '../data/brokerslist.dart';
import '../model/broker.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brokers = brokersList.map((e) => Broker.fromMap(e)).toList();
    brokers.sort((a, b) => a.code.compareTo(b.code));
    return Scaffold(
      appBar: AppBar(
        title: Text('Broker Analysis'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          final broker = brokers[i];
          return ListTile(
            tileColor: i.isEven ? Colors.black12 : null,
            title: Text(broker.name),
            leading: Text(broker.code.toString()),
            onTap: () {
              Get.to(() => Analysis(broker: broker));
            },
          );
        },
        itemCount: brokers.length,
      ),
    );
  }
}
