import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Grouped extends StatefulWidget {
  const Grouped({Key? key}) : super(key: key);

  @override
  _GroupedState createState() => _GroupedState();
}

class Sales {
  String years;
  int sales;
  Sales(this.sales, this.years);
}

class _GroupedState extends State<Grouped> {
  List<Sales> laptop = [];
  List<Sales> desktop = [];
  List<charts.Series<Sales, String>> chartData = [];
  void makeData() {
    final rnd = Random();
    for (int i = 2010; i < 2020; i++) {
      laptop.add(Sales(rnd.nextInt(1000), i.toString()));
      desktop.add(Sales(rnd.nextInt(1000), i.toString()));
    }
    chartData.add(charts.Series(
      id: 'Sales',
      domainFn: (Sales sale, _) => sale.years,
      data: laptop,
      measureFn: (Sales sale, _) => sale.sales,
      displayName: "Sales",
      colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
      fillPatternFn: (_, __) => charts.FillPatternType.forwardHatch,
    ));
    chartData.add(charts.Series(
      id: 'Sales',
      domainFn: (Sales sale, __) => sale.years,
      data: desktop,
      measureFn: (Sales sale, __) => sale.sales,
      displayName: "Sales",
      fillPatternFn: (_, __) => charts.FillPatternType.solid,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
    ));
  }

  @override
  void initState() {
    makeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            const Text('Sales Data'),
            Expanded(child: charts.BarChart(chartData))
          ],
        ),
      ),
    ));
  }
}
