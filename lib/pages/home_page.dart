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
  final newExpenseAmountDollarcontroller = TextEditingController();
  final newExpenseAmountCentscontroller = TextEditingController();

  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

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
                    decoration: const InputDecoration(
                      hintText: "Expense name",
                    ),
                  ),
                  //expense amount
                  Row(
                    children: [
                      // dollars
                      Expanded(
                        child: TextField(
                          controller: newExpenseAmountDollarcontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Dollar",
                          ),
                        ),
                      ),
                      //cents
                      Expanded(
                        child: TextField(
                          controller: newExpenseAmountCentscontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Cents",
                          ),
                        ),
                      ),
                    ],
                  )
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

//delete expense
  void deleteExpense(Expenseitem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

//save
  void save() {
    //save expense all fields are filled 
    if (newExpenseNamecontroller.text.isNotEmpty && newExpenseAmountDollarcontroller.text.isNotEmpty && newExpenseAmountCentscontroller.text.isNotEmpty) {
        // add dollars and cents
        String amount =
            '${newExpenseAmountDollarcontroller.text}.${newExpenseAmountCentscontroller.text}';

        Expenseitem newExpense = Expenseitem(
          name: newExpenseNamecontroller.text,
          amount: amount,
          dateTime: DateTime.now(),
        );
        Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
      
    }
    Navigator.pop(context);
    clear();
  }

// cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseAmountDollarcontroller.clear();
    newExpenseAmountCentscontroller.clear();
    newExpenseNamecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: ((context, value, child) => Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              backgroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
            body: ListView(
              children: [
                //weekly summary
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                const SizedBox(
                  height: 20,
                ),

                //expense list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: ((context, index) => ExpenseTile(
                        name: value.getAllExpenseList()[index].name,
                        amount: value
                            .getAllExpenseList()[index]
                            .amount,
                        dateTime: value.getAllExpenseList()[index].dateTime,
                        deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index]),
                      )),
                ),
              ],
            ))));
  }
}
