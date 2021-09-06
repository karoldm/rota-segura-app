import 'dart:ui';

import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String? title;
  final VoidCallback? function;

  Button({Key? key, this.title, this.function}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff004F77), Color(0xff3DBEFF)]),
                borderRadius: BorderRadius.circular(3)),
            child: Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  widget.title!,
                  style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
                ))),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, shadowColor: Colors.transparent),
        onPressed: widget.function!);
  }
}
