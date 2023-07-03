import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense was deleted"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  void _showAddExpenses() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addExpense: addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWith = MediaQuery.of(context).size.width;

    Widget mainContent;
    if (screenWith < 600) {
      mainContent = Column(children: [
            Chart(expenses: _registeredExpenses),
            Expanded(
              child: ExpensesList(
                list: _registeredExpenses,
                onRemove: removeExpense,
              ),
            ),
          ]);
    } else {
      mainContent = Row(
            children: [
              Expanded(child: Chart(expenses: _registeredExpenses)),
              Expanded(
                child: ExpensesList(
                  list: _registeredExpenses,
                  onRemove: removeExpense,
                ),
              ),
            ],
          );
    }

    if (_registeredExpenses.isEmpty) {
      mainContent = const Center(
        child: Text("There is no Expenses here please add some"),
      );
    }

    return Scaffold(
      body: mainContent,
      appBar: AppBar(
        title: const Text("Flutter ExpensesApp"),
        actions: [
          IconButton(onPressed: _showAddExpenses, icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
