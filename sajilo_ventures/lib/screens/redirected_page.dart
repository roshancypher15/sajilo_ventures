import 'package:flutter/material.dart';

class RedirectedPage extends StatefulWidget {
  static const routeName =' redirect';
  const RedirectedPage({Key? key}) : super(key: key);

  @override
  State<RedirectedPage> createState() => _RedirectedPageState();
}

class _RedirectedPageState extends State<RedirectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
