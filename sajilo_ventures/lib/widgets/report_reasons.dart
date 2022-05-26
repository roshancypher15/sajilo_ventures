import 'dart:async';

import 'package:flutter/material.dart';
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
      onTap: () => setState(
        () {
          _selected = index;

          _submit();
          Timer(const Duration(seconds: 5), (() {}));
        },
      ),
    );
  }

  Future<void> _submit() async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
          return Container(
              margin: const EdgeInsets.all(15),
              height: 170,
              width: 250,
              color: Colors.transparent,
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const Center(
                        child: Icon(
                          Verified.icons8_verified_account_100,
                          color: Color.fromARGB(255, 206, 41, 96),
                          size: 100,
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 320,
                          child: const Text(
                            'Rider Report Successful',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )));
        });
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
