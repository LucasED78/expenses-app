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
      child: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (builder, index){
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(_transactions[index].amount.toStringAsFixed(1),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.orange),
                  ),
                  decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.orange,
                      width: 2
                    )
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(_transactions[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(DateFormat('dd/MM/yyyy').format(_transactions[index].date),
                      style: TextStyle(color: Colors.black26, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }
}