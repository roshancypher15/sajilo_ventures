import 'package:flutter/material.dart';

class DashboardFilterDropDown extends StatefulWidget {
  const DashboardFilterDropDown({Key? key}) : super(key: key);

  @override
  State<DashboardFilterDropDown> createState() =>
      _DashboardFilterDropDownState();
}

class _DashboardFilterDropDownState extends State<DashboardFilterDropDown> {
  final filterLimit = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
  String? filterBy;

  DropdownMenuItem<String> buildMenuItems(String type) => DropdownMenuItem(
      value: type,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
        child: Text(
          type,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ));
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 8),
        height: 40,
        width: 105,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 238, 237, 237),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white)),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.only(right: 5, left: 2),
            child: DropdownButton(
              iconSize: 20,
              isExpanded: true,
              icon: const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(Icons.arrow_drop_down),
              ),
              hint: filterBy != null
                  ? Text('$filterBy')
                  : const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text('Option')),
              value: filterBy,
              items: filterLimit.map(buildMenuItems).toList(),
              onChanged: (value) => setState(() => filterBy = value as String),
            ),
          ),
        ),
      ),
    );
  }
}
