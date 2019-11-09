import 'package:expenses_app/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: MyHomePage(),
  )
);

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text("CHART!!"),
            ),
          ),
          Column(children: transactions.map<Widget>(
            (tx) => Card(child: Text(tx.name))
          ).toList())
        ],
      ),
    );
  }
}