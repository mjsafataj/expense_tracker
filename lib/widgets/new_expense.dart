import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.addExpense, Key? key}) : super(key: key);

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category category = Category.leisure;
  DateTime? selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final start = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: start,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _validForm() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text);
    final isAmountInvalid = amount == null || amount <= 0;
    if (title.isEmpty || isAmountInvalid || selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Alert"),
                content: const Text("Form is Invalid"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }
    widget.addExpense(Expense(
      title: title,
      amount: amount,
      date: selectedDate!,
      category: category,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constrains) => SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboard + 16),
            child: Column(children: [
              if (constrains.minWidth <= 600)
                TextField(
                  maxLength: 50,
                  controller: _titleController,
                  decoration: const InputDecoration(label: Text("Title")),
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        maxLength: 50,
                        controller: _titleController,
                        decoration: const InputDecoration(label: Text("Title")),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: const InputDecoration(
                          label: Text("Amount"),
                          prefix: Text("\$ "),
                        ),
                      ),
                    )
                  ],
                ),
              if (constrains.minWidth <= 600)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: const InputDecoration(
                          label: Text("Amount"),
                          prefix: Text("\$ "),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Text(selectedDate == null
                            ? "no date selected"
                            : formatter.format(selectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    DropdownButton(
                        value: category,
                        items: Category.values.map((category) {
                          return DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            category = value;
                          });
                        }),
                    const SizedBox(width: 24),
                    Row(
                      children: [
                        Text(selectedDate == null
                            ? "no date selected"
                            : formatter.format(selectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ],
                ),
              if (constrains.minWidth <= 600)
                Row(children: [
                  DropdownButton(
                      value: category,
                      items: Category.values.map((category) {
                        return DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          category = value;
                        });
                      }),
                  const SizedBox(width: 24),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          child: const Text("cansel"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      ElevatedButton(
                          onPressed: _validForm, child: const Text("save")),
                    ],
                  )
                ])
              else
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        child: const Text("cansel"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    ElevatedButton(
                      onPressed: _validForm,
                      child: const Text("save"),
                    ),
                  ],
                ),
            ]),
          ),
        ),
      ),
    );

    // else
  }
}
