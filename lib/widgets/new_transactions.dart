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
                Text(
                  _selectedDate == null ? "No date chosen" : DateFormat("dd/MM/yyyy").format(_selectedDate)
                ),
                FlatButton(
                  child: Text("Chose data", 
                    style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed:_presentDatePicker
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