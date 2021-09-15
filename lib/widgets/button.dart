import 'dart:ui';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback function;
  final List<int> colors;

  Button(
      {Key? key,
      required this.title,
      required this.function,
      required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
            child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(colors[0]), Color(colors[1])]),
                    borderRadius: BorderRadius.circular(3)),
                child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
                    ))),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero, shadowColor: Colors.transparent),
            onPressed: function));
  }
}
