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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(_transactions[index].amount.toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Theme.of(context).accentColor),
                  ),
                  decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 2
                    )
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(_transactions[index].name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(DateFormat('dd/MM/yyyy').format(_transactions[index].date),
                      style: Theme.of(context).textTheme.subtitle,
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