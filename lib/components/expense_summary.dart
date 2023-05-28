import 'package:daily_expense_tracker/bar%20graph/bar_graph.dart';
import 'package:daily_expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100,
          sunAmount: 20, 
          monAmount: 50, 
          tueAmount: 10, 
          wedAmount: 30, 
          thuAmount: 24, 
          friAmount: 3, 
          satAmount: 90),
      ),
    );
  }
}
