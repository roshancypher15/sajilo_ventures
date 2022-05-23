import 'package:flutter/material.dart';

class RadioComponent extends StatefulWidget {
  const RadioComponent({Key? key}) : super(key: key);

  @override
  State<RadioComponent> createState() => _RadioComponentState();
}

class _RadioComponentState extends State<RadioComponent> {
  int? _selected;
  var id = 1;

  Widget _icon(int index, {required String text, required IconData icon}) {
    return InkResponse(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 25,
              color: _selected == index ? Colors.green : null,
            ),
            Text(text,
                style:
                    TextStyle(color: _selected == index ? Colors.green : null)),
          ],
        ),
      ),
      onTap: () => setState(
        () {
          _selected = index;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _icon(0, text: "Rides", icon: Icons.circle_outlined),
        _icon(1, text: "Earnings", icon: Icons.circle_outlined),
      ],
    );
  }
}
