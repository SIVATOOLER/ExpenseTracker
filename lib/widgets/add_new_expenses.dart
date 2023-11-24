import 'dart:ffi';
import 'dart:io';
import 'package:expenses/model/expense_model.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class AddNewExpenses extends StatefulWidget {
  const AddNewExpenses({super.key, required this.addExpense});
  final void Function(Expenses data) addExpense;
  @override
  State<AddNewExpenses> createState() => _AddNewExpensesState();
}

class _AddNewExpensesState extends State<AddNewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Categories _selectedCategory = Categories.work;

  void _datePicker() async {
    final today = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2000),
      lastDate: today,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _submitExpenseData() {
   final iosPlatform= Platform.isIOS;
    final intAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = intAmount == null || intAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      iosPlatform? showCupertinoDialog(context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Inputs'),
          content: const Text("Field Can't be Empty"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      ): showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Inputs'),
          content: const Text("Field Can't be Empty"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }

    widget.addExpense(
      Expenses(
        title: _titleController.text,
        dateTime: _selectedDate!,
        amount: intAmount,
        categories: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (cxt,constrains){
      final width =constrains.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.fromLTRB(10.0, 50, 10, MediaQuery.of(context).viewInsets.bottom+10),
            child: Column(
              children: [
               if (width>=600)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0,right: 10),
                    child: TextField(
                    maxLength: 10,
                      controller: _titleController,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    decoration: const InputDecoration(
                      label: Text('Amount'),
                    ),
                  ),
                ),
              ],
            )else
                TextField(
                  maxLength: 10,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),

                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    width>=600? Container(): Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: const InputDecoration(
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : "$_selectedDate".substring(0, 10),
                            ),
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Categories.values
                          .map(
                            (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    ElevatedButton(
                        onPressed: () {
                          _submitExpenseData();
                        },
                        child: const Text("Save Expense"))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

  }
}
