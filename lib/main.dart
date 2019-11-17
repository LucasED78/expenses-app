import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart.dart';
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
      errorColor: Colors.red,
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
        ),
        button: TextStyle(
          color: Colors.white,
        )
      ),
      buttonColor: Colors.orange
    ),
  )
);

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7))
      );
    }).toList();
  }
  
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {

    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final txList = Container(
    height: (
        MediaQuery.of(context).size.height - AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top) * 0.7,
      child: TransactionList(transactions, _deleteTransaction),
    );

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
          if (isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Show chart"),
              Switch(
                value: _showChart,
                onChanged: (value){
                  setState(() {
                    _showChart = value;
                  });
                },
              )
            ],
          ),
          if (isLandscape) _showChart ? Container(
            height: (
              MediaQuery.of(context).size.height - AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top) * 0.7,
            child: Chart(_recentTransactions)
          ) : txList,

          if (!isLandscape) Container(
            height: (
              MediaQuery.of(context).size.height - AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top) * 0.3,
            child: Chart(_recentTransactions)
          ),

          if (!isLandscape) txList 
          
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

  void _addTransaction(String text, double amount, DateTime date){
    Transaction newTx = Transaction(
      id: DateTime.now().toString(),
      name: text,
      amount: amount,
      date: date
    );

    setState(() {
      transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }
}