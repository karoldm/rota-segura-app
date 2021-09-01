import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? textType;

  const Input({Key? key, this.placeholder, this.controller, this.textType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: widget.textType,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            hintText: widget.placeholder,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.6))));
  }
}
