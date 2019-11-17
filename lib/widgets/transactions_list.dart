import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteItem;

  TransactionList(this._transactions, this._deleteItem);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty ? LayoutBuilder(
      builder: (context, constraint){
        return Column(
          children: <Widget>[
            Text("No transactions added yet.", 
              style: Theme.of(context).textTheme.title
            ),
            SizedBox(width: 10, height: 10),
            Container(
              height: constraint.maxHeight * 0.6,
              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover)
            )
          ],
        );
      },
    ) : ListView.builder(
      itemCount: _transactions.length,
      itemBuilder: (builder, index){
        return Dismissible(
          key: Key(_transactions[index].id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) => _deleteItem(_transactions[index].id),
          background: Container(color: Colors.redAccent),
          child: Card(
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
          ),
        );
      }
    );
  }
}