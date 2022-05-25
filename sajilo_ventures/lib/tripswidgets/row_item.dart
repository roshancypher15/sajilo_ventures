import 'package:flutter/material.dart';

class RowItem extends StatefulWidget {
  final String title;
  final String data;
  const RowItem(this.title, this.data, {Key? key}) : super(key: key);

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.title,
          style: const TextStyle(fontSize: 15),
        ),
        Text(widget.data,
            style: const TextStyle(
                fontSize: 17,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ],
    );
  }
}
