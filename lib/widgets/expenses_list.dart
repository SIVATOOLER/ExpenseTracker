import 'package:expenses/model/expense_model.dart';
import 'package:expenses/widgets/expenses_items.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.removeExpense,
  });
  final List<Expenses> expensesList;
  final void Function(Expenses data) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: expensesList.length,
        itemBuilder: (context, index) {
          return Dismissible(
              onDismissed: (value) {
                removeExpense(expensesList[index]);
                print(expensesList);
              },
              background: Container(
                margin: Theme.of(context).cardTheme.margin,
                color: Theme.of(context).colorScheme.error,
              ),
              key: ValueKey(expensesList[index]),
              child: ExpensesItems(
                data: expensesList[index],
              ));
        });
  }
}
