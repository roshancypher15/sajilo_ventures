import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:sajilo_ventures/marker_icons.dart';
import 'package:sajilo_ventures/screens/redirected_page.dart';

class AutoComplete extends StatefulWidget {
  const AutoComplete({Key? key}) : super(key: key);

  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  final _startSearchFieldController = TextEditingController();
  final _endSearchFieldController = TextEditingController();
  late GooglePlace _googlePlace;
  List<AutocompletePrediction> _predictions = [];
  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  @override
  void initState() {
    String apiKey = 'AIzaSyAZ6HwE0tRcLWAaQU8UZllVg1qmXGnDna4';
    _googlePlace = GooglePlace(apiKey);
    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await _googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.last.description);
      setState(() {
        _predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                focusNode: startFocusNode,
                autofocus: false,
                controller: _startSearchFieldController,
                style: const TextStyle(fontSize: 24),
                decoration: InputDecoration(
                    hintText: 'Starting Point',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    suffixIcon: _startSearchFieldController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _predictions = [];
                              _startSearchFieldController.clear();
                            },
                            icon: const Icon(Icons.clear_outlined))
                        : null),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    setState(() {
                      _predictions = [];
                      startPosition = null;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                focusNode: endFocusNode,
                enabled: _startSearchFieldController.text.isNotEmpty &&
                    startPosition != null,
                autofocus: false,
                controller: _endSearchFieldController,
                style: const TextStyle(fontSize: 24),
                decoration: InputDecoration(
                    hintText: 'End Point',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    suffixIcon: _endSearchFieldController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _predictions = [];
                              _endSearchFieldController.clear();
                            },
                            icon: const Icon(Icons.clear_outlined))
                        : null),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    setState(() {
                      _predictions = [];
                      endPosition = null;
                    });
                  }
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(
                    Marker1.location_2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    _predictions[index].description.toString(),
                  ),
                  onTap: () async {
                    final placeId = _predictions[index].placeId;
                    final details = await _googlePlace.details.get(placeId!);
                    if (details != null && details.result != null && mounted) {
                      if (startFocusNode.hasFocus) {
                        setState(() {
                          startPosition = details.result;
                          _startSearchFieldController.text =
                              details.result!.name!;
                          FocusScope.of(context).requestFocus(endFocusNode);

                          _predictions = [];
                        });
                      } else {
                        setState(() {
                          endPosition = details.result;
                          _endSearchFieldController.text =
                              details.result!.name!;
                          FocusScope.of(context).unfocus();
                          _predictions = [];
                        });
                      }
                      if (startPosition != null && endPosition != null) {
                        Navigator.of(context)
                            .pushNamed(RedirectedPage.routeName, arguments: [
                          _startSearchFieldController.text,
                          _endSearchFieldController.text
                        ]);
                      }
                    }
                  },
                ),
                itemCount: _predictions.length,
              ),
            ],
          ),
        ));
  }
}
