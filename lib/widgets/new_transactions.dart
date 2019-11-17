import 'dart:io';

import 'package:expenses_app/widgets/adptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {

  final Function _addNewTransaction;


  NewTransactions(this._addNewTransaction);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitTransaction(){
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0) return;

    widget._addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((DateTime pickedDate){
      if (pickedDate != null){
        setState(() {
          _selectedDate = pickedDate;
        });
      }
      else return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10
        ),
        child: Column(
          children: <Widget>[
            Card(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "name"
                ),
                controller: titleController,
                onSubmitted: (_) => _submitTransaction(),
              ),
            ),
            Card(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "amount"
                ),
                controller: amountController,
                onSubmitted: (_) => _submitTransaction(),
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: <Widget>[
                  Text(
                    _selectedDate == null ? "No date chosen" : DateFormat("dd/MM/yyyy").format(_selectedDate)
                  ),
                  AdaptiveFlatButton(
                    text: "Chose date",
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text("Add Transaction", style: Theme.of(context).textTheme.button),
              color: Theme.of(context).buttonColor,
              onPressed: _submitTransaction,
            )
          ],
        ),
      ),
    );
  }
}