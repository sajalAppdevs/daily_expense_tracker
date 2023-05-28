import 'package:daily_expense_tracker/components/expense_summary.dart';
import 'package:daily_expense_tracker/components/expense_tile.dart';
import 'package:daily_expense_tracker/data/expense_data.dart';
import 'package:daily_expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controllers
  final newExpenseNamecontroller = TextEditingController();
  final newExpenseAmountcontroller = TextEditingController();

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add new expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //expense name
                  TextField(
                    controller: newExpenseNamecontroller,
                  ),
                  //expense amount
                  TextField(
                    controller: newExpenseAmountcontroller,
                  ),
                ],
              ),
              actions: [
                //save button
                MaterialButton(
                  onPressed: save,
                  child: Text('Save'),
                ),
                //cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: Text('Cancel'),
                ),
              ],
            ));
  }

//save
  void save() {
    Expenseitem newExpense = Expenseitem(
      name: newExpenseNamecontroller.text,
      amount: newExpenseAmountcontroller.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

// cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseAmountcontroller.clear();
    newExpenseNamecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: ((context, value, child) => Scaffold(
              backgroundColor: Colors.grey[300],
              floatingActionButton: FloatingActionButton(
                onPressed: addNewExpense,
                child: Icon(Icons.add),
              ),

              body: ListView( children: [

                //weekly summary
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),


                //expense list
                 ListView.builder(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getAllExpenseList().length,
                    itemBuilder: ((context, index) => ExpenseTile(
                          name: value.getAllExpenseList()[index].name,
                          amount: value.getAllExpenseList()[index].dateTime.toString(),
                          dateTime: value.getAllExpenseList()[index].dateTime,
                        )),
                        ),
              ],)
            )));
  }
}
