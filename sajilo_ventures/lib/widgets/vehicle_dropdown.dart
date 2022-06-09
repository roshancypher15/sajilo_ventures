import 'package:flutter/material.dart';

class VehicleDropDown extends StatefulWidget {
  final void Function(String vehicleType) sendBackValue;
  const VehicleDropDown(this.sendBackValue, {Key? key}) : super(key: key);

  @override
  State<VehicleDropDown> createState() => _VehicleDropDownState();
}

class _VehicleDropDownState extends State<VehicleDropDown> {
  final vehicles = ['Bike', 'Scooter', 'Taxi', 'Car', 'Pick up Van'];
  String? itemValue;

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
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: Colors.grey, width: 1)),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: DropdownButton(
              iconSize: 25,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              hint: const Text('Select an option.'),
              value: itemValue,
              items: vehicles.map(buildMenuItems).toList(),
              onChanged: (value) => setState(() {
                itemValue = value as String;
                widget.sendBackValue(itemValue!);
              }),
            ),
          ),
        ),
      ),
    );
  }
}
