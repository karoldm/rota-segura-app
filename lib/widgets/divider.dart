import 'package:flutter/material.dart';

class DividerForm extends StatelessWidget {
  final String text;

  DividerForm({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(children: <Widget>[
        Expanded(child: Divider(color: Color(0xff035883), thickness: 1.5)),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              this.text,
              style: TextStyle(fontSize: 18, color: Color(0xff035883)),
            )),
        Expanded(child: Divider(color: Color(0xff035883), thickness: 1.5)),
      ]),
    ));
  }
}
