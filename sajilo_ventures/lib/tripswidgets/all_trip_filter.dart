import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class AllTripFilter extends StatelessWidget {
  String days;
  AllTripFilter(this.days, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: (() {}),
        splashFactory: InkRipple.splashFactory,
        child: Container(
          width: 65,
          height: 25,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 239, 239),
              borderRadius: BorderRadius.circular(5)),
          child: Center(child: Text(days)),
        ),
      ),
    );
  }
}
