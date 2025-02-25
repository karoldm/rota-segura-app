import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final TextInputType textType;
  final bool readOnly;

  Input(
      {Key? key,
      required this.placeholder,
      required this.controller,
      required this.textType,
      required this.readOnly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          //verificando se o campo foi preenchido
          if (value == null || value.isEmpty) {
            return 'Esse campo precisa ser preenchido';
          }
          return null;
        },
        readOnly: widget.readOnly,
        keyboardType: widget.textType, //tipo do teclado
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
