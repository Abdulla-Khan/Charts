import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class Sales {
  String years;
  int sales;
  Sales(this.sales, this.years);
}

class _ChatState extends State<Chat> {
  List<Sales> data = [];
  List<charts.Series<Sales, String>> chartData = [];
  void makeData() {
    final rnd = Random();
    for (int i = 2010; i < 2020; i++) {
      data.add(Sales(
        rnd.nextInt(1000),
        i.toString(),
      ));
    }
    chartData.add(charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        data: data,
        domainFn: (Sales sale, _) => sale.years,
        measureFn: (Sales sale, _) => sale.sales,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        displayName: 'sales'));
  }

  @override
  void initState() {
    super.initState();
    makeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Text('Sales Data'),
            Expanded(child: charts.BarChart(chartData))
          ],
        ),
      ),
    ));
  }
}
