import 'package:expenses/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesItems extends StatelessWidget {
  const ExpensesItems({super.key, required this.data});
  final Expenses data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.amount.toStringAsFixed(2)),
                Row(
                  children: [
                    Icon(categoriesIcon[data.categories]),
                    Text(data.dateFormat),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
