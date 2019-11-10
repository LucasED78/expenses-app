import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactions.isEmpty ? Column(
        children: <Widget>[
          Text("No transactions added yet.", 
            style: Theme.of(context).textTheme.title
          ),
          SizedBox(width: 10, height: 10),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover)
          )
        ],
      ) : ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (builder, index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.all(6),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: FittedBox(child: Text(_transactions[index].amount.toStringAsFixed(2))),
                  foregroundColor: Colors.white,
                )
              ),
              title: Text(_transactions[index].name, style: Theme.of(context).textTheme.title),
              subtitle: Text(_transactions[index].amount.toStringAsFixed(2), style: Theme.of(context).textTheme.subtitle),
            ),
          );
        }
      ),
    );
  }
}