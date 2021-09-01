import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rota_segura_app/widgets/appName_widget.dart';
import 'package:rota_segura_app/widgets/button_widget.dart';
import 'package:rota_segura_app/widgets/inputPassword_widget.dart';
import 'package:rota_segura_app/widgets/input_widget.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';

//models
import 'package:rota_segura_app/models/user_model.dart';

//screens
import 'package:rota_segura_app/screens/profile_screen.dart';
import 'package:rota_segura_app/screens/register_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff004F77), Color(0xff3DBEFF)])),
          child: Column(
            children: <Widget>[
              AppName(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 60, 0, 0),
                    child: Text(
                      'Entre com sua conta',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      placeholder: 'email',
                      controller: _emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: InputPassword(
                      placeholder: 'senha',
                      controller: _passwordController,
                    ),
                  ),
                  ScopedModelDescendant<UserModel>(
                      builder: (context, child, model) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Button(
                            title: 'entrar',
                            function: () {
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              model.signIn(email, password, () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              }, () {
                                print('erro ao logar');
                              });
                            }));
                  })
                ],
              )),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 80),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0)),
                child: Text(
                  'Ainda não tem uma conta ? Cadastre-se aqui',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()))))
      ],
    ))));
  }
}
