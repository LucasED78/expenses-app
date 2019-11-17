import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekday;
  final double amount;
  final double perc;


  ChartBar(this.weekday, this.amount, this.perc);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint){
        return Column(
          children: <Widget>[
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(weekday))
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            Stack(
              children: <Widget>[
                Container(
                  height: constraint.maxHeight * 0.6,
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
            SizedBox(height: constraint.maxHeight * 0.05),
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(amount.toStringAsFixed(2))),
            )
          ],
        );
      },
    );
  }
}