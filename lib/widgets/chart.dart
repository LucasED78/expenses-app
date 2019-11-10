import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactions{
    return List.generate(7, (index){

      final DateTime weekday = DateTime.now().subtract(Duration(days: index));
      double amount = 0;
      for (Transaction tx in _recentTransactions){
        if (tx.date.day == weekday.day &&
            tx.date.month == weekday.month &&
            tx.date.year == weekday.year){
              amount += tx.amount;
            }
      }

      return { 
        'weekday': DateFormat.E().format(weekday),
        'amount': amount
       }; 
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, item){
      return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map<Widget>((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['weekday'], 
                data['amount'], 
                totalSpending == 0.0 ? 0.0 :
                (data['amount'] as double) / totalSpending
              ),
            );
          }).toList()
        ),
      ),
    );
  }
}