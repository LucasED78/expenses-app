import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'transaction_item.dart';

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
    ) : ListView(
      children: _transactions.map<Widget>((tx) => TransactionItem(
        key: ValueKey(tx.id),
        transaction: tx,
        deleteItem: _deleteItem,
      )).toList(),
    );
  }
}