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
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                Text("No date chosen"),
                FlatButton(
                  child: Text("Chose date", style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: () => {},
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
    );
  }
}