import 'package:expenses/model/expense_model.dart';
import 'package:expenses/widgets/add_new_expenses.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expenses> expenseList = [
    // Expenses(
    //     title: "title1",
    //     amount: 10,
    //     dateTime: DateTime.now(),
    //     categories: Categories.food),
    // Expenses(
    //     title: "title2",
    //     amount: 20,
    //     dateTime: DateTime.now(),
    //     categories: Categories.leisure),
    // Expenses(
    //     title: "title3",
    //     amount: 30,
    //     dateTime: DateTime.now(),
    //     categories: Categories.travel),
    // Expenses(
    //     title: "title4",
    //     amount: 40,
    //     dateTime: DateTime.now(),
    //     categories: Categories.work),
    // Expenses(
    //     title: "title5",
    //     amount: 50,
    //     dateTime: DateTime.now(),
    //     categories: Categories.food),
  ];
  void addExpense(Expenses data) {
    setState(() {
      expenseList.add(data);
    });
  }

  void removeExpense(Expenses data) {
    final expenseIndex = expenseList.indexOf(data);
    setState(() {
      expenseList.remove(data);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Deleted Successfully.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenseList.insert(expenseIndex, data);
            });
          },
        ),
      ),
    );
  }

  bottomSheetFun() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (
          cxt,
        ) {
          return AddNewExpenses(
            addExpense: addExpense,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
   var width= MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No Expense Found"),
    );
    if (expenseList.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: expenseList,
        removeExpense: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expenses Tracker"),
        actions: [
          IconButton(
              onPressed: () {
                bottomSheetFun();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body:width<600? Column(
        children: [Chart(expenses: expenseList), Expanded(child: mainContent)],
      ):Row(
        children: [Expanded(child: Chart(expenses: expenseList)), Expanded(child: mainContent)],
      )
    );
  }
}
