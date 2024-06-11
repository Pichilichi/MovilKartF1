

import 'package:flutter/material.dart';

class CircPage extends StatefulWidget{
  const CircPage({Key? key}) : super(key: key);

  @override
  _CircPageState createState() => _CircPageState();
}

class _CircPageState extends State<CircPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text(
        'Holaa circuitos',
      ) ,
      ],
    );
  }
}