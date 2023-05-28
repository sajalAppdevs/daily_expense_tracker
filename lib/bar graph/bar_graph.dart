import 'package:daily_expense_tracker/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph(
      {super.key,
      this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount});


  @override
  Widget build(BuildContext context) {
    //initialize bar data
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thuAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );
    myBarData.initializeBarData();
    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      barGroups: myBarData.barData.map((data) => BarChartGroupData(x: data.x,
      barRods: [BarChartRodData(toY: data.y)])).toList(),
    ));
  }
}
