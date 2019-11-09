import 'package:flutter/material.dart';

class NewTransactions extends StatelessWidget {

  final Function _addNewTransaction;

  final titleController = TextEditingController();
  final amountController = TextEditingController();


  NewTransactions(this._addNewTransaction);

  void _submitTransaction(){
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0) return;

    _addNewTransaction(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        FlatButton(
          child: const Text("Add Transaction", style: TextStyle(color: Colors.orange)),
          onPressed: _submitTransaction,
        )
      ],
    );
  }
}