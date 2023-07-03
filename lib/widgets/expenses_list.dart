import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.list, required this.onRemove, super.key});

  final void Function(Expense expense) onRemove;
  final List<Expense> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (ctx, index) => Dismissible(
              onDismissed: (direction) {
                onRemove(list[index]);
              },
              key: ValueKey(list[index]),
              child: ExpenseItem(list[index]),
            ));
  }
}
