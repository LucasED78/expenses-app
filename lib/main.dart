import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:expenses_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: MyHomePage(),
    theme: ThemeData(
      primarySwatch: Colors.orange,
      accentColor: Colors.lightGreen,
      iconTheme: IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          title: TextStyle(color: Colors.white, 
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 20)
        )
      ),
      textTheme: TextTheme(
        subtitle: TextStyle(
          fontFamily: "QuickSand",
          color: Colors.grey,
          fontSize: 16
        ),
        title: TextStyle(
          fontFamily: "OpenSang",
          color: Colors.black,
          fontSize: 18
        )
      )
    ),
  )
);

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses", 
          style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showModal(context),
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text("CHART!!"),
            ),
          ),
          TransactionList(transactions)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: () => _showModal(context),
        tooltip: "adiciona coisa nova",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<Widget> _showModal(BuildContext ctx){
    return showModalBottomSheet(
      context: ctx,
      builder: (context){
        return NewTransactions(_addTransaction);
      }
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