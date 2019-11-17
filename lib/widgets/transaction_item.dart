import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expenses_app/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteItem,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteItem;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState
    List randomColor = [
      Colors.red,
      Colors.teal,
      Colors.purple,
      Colors.blue
    ];

    _bgColor = randomColor[Random().nextInt(4)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.transaction.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) => widget.deleteItem(widget.transaction.id),
      background: Container(color: Colors.redAccent),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.all(6),
            child: CircleAvatar(
              backgroundColor: _bgColor,
              child: FittedBox(child: Text(widget.transaction.amount.toStringAsFixed(2))),
              foregroundColor: Colors.white,
            )
          ),
          title: Text(widget.transaction.name, style: Theme.of(context).textTheme.title),
          subtitle: Text(widget.transaction.amount.toStringAsFixed(2), style: Theme.of(context).textTheme.subtitle),
        ),
      ),
    );
  }
}