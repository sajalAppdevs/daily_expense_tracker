import 'package:daily_expense_tracker/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  // reference our box
  final _myBox = Hive.box("expense_database");

  //write data
  void saveData(List<Expenseitem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];
    //converted each expenseItem into list (string, datetime)
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      // all expenses
      allExpensesFormatted.add(expenseFormatted);
    }

    //store in database
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  //read data
  List<Expenseitem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<Expenseitem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      //individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // create expense item
      Expenseitem expense =
          Expenseitem(name: name, amount: amount, dateTime: dateTime);

      allExpenses.add(expense);
    }
    return allExpenses;
  }



}
