import 'package:flutter/cupertino.dart';

class Transaction {
  String id;
  String name;
  double amount;
  DateTime date;

  Transaction({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.date
  });

  factory Transaction.fromJSON(dynamic data){
    return new Transaction(
      id: data['id'],
      name: data['name'],
      amount: data['amount'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date'])
    );
  }
}