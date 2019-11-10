import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekday;
  final double amount;
  final double perc;


  ChartBar(this.weekday, this.amount, this.perc);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weekday),
        const SizedBox(height: 4),
        Stack(
          children: <Widget>[
            Container(
              height: 60,
              width: 10,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 4),
                borderRadius: BorderRadius.circular(20)
              ),
              child: FractionallySizedBox(
                heightFactor: perc,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor)
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 20,
          child: FittedBox(child: Text(amount.toStringAsFixed(2))),
        )
      ],
    );
  }
}