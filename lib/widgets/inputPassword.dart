import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  final String? placeholder;
  final TextEditingController? controller;

  const InputPassword({Key? key, this.placeholder, this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _viewPassword = true;
  //função para exibir e esconder texto da senha
  void _toggleViewPassword() {
    setState(() {
      _viewPassword = !_viewPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          //verificando se o campo foi preenchido
          if (value == null || value.isEmpty) {
            return 'Esse campo precisa ser preenchido';
          } else if (value.length < 6) {
            return 'A senha deve conter mais de seis caracteres';
          }
          return null;
        },
        obscureText: _viewPassword, //texto escondido
        autocorrect: false, //nunca sugerir valor para senha
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintText: widget.placeholder,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
          //icone para esconder senha
          suffixIcon: IconButton(
            color: Colors.black,
            onPressed: _toggleViewPassword,
            icon: Icon(Icons.lock, color: Colors.black),
          ),
        ));
  }
}
