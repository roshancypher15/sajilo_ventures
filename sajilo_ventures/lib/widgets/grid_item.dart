import 'package:flutter/material.dart';

class GridItems extends StatefulWidget {
  final String title;
  final int number;
  const GridItems(this.title, this.number, {Key? key}) : super(key: key);

  @override
  State<GridItems> createState() => _GridItemsState();
}

class _GridItemsState extends State<GridItems> {
  var _ispressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 241, 239, 239)),
          child: InkWell(
            onTap: (() {
              setState(() {
                _ispressed = !_ispressed;
              });
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 16,
                        color: Color.fromARGB(255, 88, 87, 87)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(widget.number.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _ispressed
            ? Container(
                width: 140,
                height: 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(199, 33, 38, 1)),
              )
            : const SizedBox(
                height: 1,
              )
      ],
    );
  }
}
