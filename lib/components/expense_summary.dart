import 'package:daily_expense_tracker/bar%20graph/bar_graph.dart';
import 'package:daily_expense_tracker/data/expense_data.dart';
import 'package:daily_expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tueday,
    String wedday,
    String thuday,
    String friday,
    String satday,
  ) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tueday] ?? 0,
      value.calculateDailyExpenseSummary()[wedday] ?? 0,
      value.calculateDailyExpenseSummary()[thuday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[satday] ?? 0,
    ];

    // sort small to large
    values.sort();
    // cap graph looks full
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  //caculate total week cost
  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tueday,
    String wedday,
    String thuday,
    String friday,
    String satday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tueday] ?? 0,
      value.calculateDailyExpenseSummary()[wedday] ?? 0,
      value.calculateDailyExpenseSummary()[thuday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[satday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    //get yyyymmdd for each day of this week
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          //week total
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Week Total:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}'),
              ],
            ),
          ),

          //bar graph
          SizedBox(
            height: 200,
            child: MyBarGraph(
                maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                    thursday, friday, saturday),
                sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
                monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
                tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                thuAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
                friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
                satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0),
          ),
        ],
      ),
    );
  }
}
