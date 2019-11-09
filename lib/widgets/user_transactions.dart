import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:expenses_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
    final List<Transaction> transactions = [
      Transaction(
        id: 't1',
        name: "New shoes",
        amount: 40.00,
        date: DateTime.now()
      ),
      Transaction(
        id: 't1',
        name: "New shoes",
        amount: 40.00,
        date: DateTime.now()
      )
    ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransactions(_addTransaction),
        TransactionList(transactions)
      ],
    );
  }

  void _addTransaction(String text, double amount){
    Transaction newTx = Transaction(
      id: DateTime.now().toString(),
      name: text,
      amount: amount,
      date: DateTime.now()
    );

    setState(() {
      transactions.add(newTx);
    });
  }
}