import 'package:flutter/material.dart';

class GrowthLossIndicator extends StatefulWidget {
  const GrowthLossIndicator({Key? key}) : super(key: key);

  @override
  State<GrowthLossIndicator> createState() => _GrowthLossIndicatorState();
}

class _GrowthLossIndicatorState extends State<GrowthLossIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 35, top: 8),
        height: 40,
        width: 70,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 247, 209, 209),
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: Colors.white)),
        child: const Center(child: Text('+2.5 %')));
  }
}
