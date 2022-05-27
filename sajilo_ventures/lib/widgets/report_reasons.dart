import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sajilo_ventures/screens/redirected_page.dart';
import 'package:sajilo_ventures/verified_icons.dart';

class ReportReason extends StatefulWidget {
  const ReportReason({Key? key}) : super(key: key);

  @override
  State<ReportReason> createState() => _ReportReasonState();
}

class _ReportReasonState extends State<ReportReason> {
  int? _selected;
  var id = 1;

  Widget _icon(
    int index, {
    required String text,
  }) {
    return InkResponse(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          top: 20,
        ),
        child: Text(text,
            style: TextStyle(
              color: _selected == index ? Colors.pink : Colors.grey,
              fontSize: 17,
            )),
      ),
      onTap: () => setState(() {
        _selected = index;

        Navigator.of(context).pushNamed(RedirectedPage.routeName);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _icon(
          0,
          text: "Rider refused to pick me up from the pickup Location.",
        ),
        _icon(
          1,
          text: "Rider was ride.",
        ),
        _icon(2, text: 'Rider didn\'t give me helmet.'),
      ],
    );
  }
}
