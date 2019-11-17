import 'dart:io';

import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:expenses_app/widgets/transactions_list.dart';
import 'package:flutter/cupertino.dart';
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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

    List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, Widget txList, AppBar appBar){
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Show chart", style: Theme.of(context).textTheme.title,),
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
        _showChart ? Container(
          height: (
            mediaQuery.size.height - AppBar().preferredSize.height -
            mediaQuery.padding.top) * 0.7,
          child: Chart(_recentTransactions)
        ) : txList
      ];
    }

    _buildPortraitContent(MediaQueryData mediaQuery, Widget txList, AppBar appBar){
      return [
        Container(
          height: (
            mediaQuery.size.height - AppBar().preferredSize.height -
            mediaQuery.padding.top) * 0.3,
          child: Chart(_recentTransactions)
        ),
        txList
      ];
    }

    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    

    final txList = Container(
    height: (
        mediaQuery.size.height - AppBar().preferredSize.height -
        mediaQuery.padding.top) * 0.7,
      child: TransactionList(transactions, _deleteTransaction),
    );

    final appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text("Expenses App"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => _showModal(context),
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
    ) : AppBar(
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
      );

    final appBody = SafeArea(
      child: Column(
        children: <Widget>[
          if (isLandscape) ..._buildLandscapeContent(mediaQuery, txList, appBar),

          if (!isLandscape) ..._buildPortraitContent(mediaQuery, txList, appBar)
 
        ],
      ),
    );
      
     return Platform.isIOS ? CupertinoPageScaffold(
       child: appBody,
       navigationBar: CupertinoNavigationBar(

       ),
     ) : Scaffold(
      appBar: appBar,
      body: appBody,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
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