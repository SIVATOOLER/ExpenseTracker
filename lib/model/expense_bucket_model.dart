import 'package:expenses/model/expense_model.dart';

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expenses> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.categories == category)
            .toList();

  final Categories category;
  final List<Expenses> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
