// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
//models
import 'package:rota_segura/models/user.dart';
//screens
import 'package:rota_segura/screens/login.dart';
//widgets
import 'package:rota_segura/widgets/appName.dart';
import 'package:rota_segura/widgets/button.dart';
import 'package:rota_segura/widgets/divider.dart';
import 'package:rota_segura/widgets/input.dart';
import 'package:rota_segura/widgets/inputPassword.dart';
//libraries
import 'package:scoped_model/scoped_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _telController = TextEditingController();
  final _cpfController = TextEditingController();
  final _birthController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff004F77), Color(0xff3DBEFF)],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    AppName(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 60, 0, 0),
                        child: Text(
                          'Preencha os campos com seus dados',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      DividerForm(text: 'Dados Pessoais'),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.text,
                          placeholder: 'nome completo',
                          controller: _nameController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.number,
                          placeholder: 'telefone',
                          controller: _telController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.number,
                          placeholder: 'CPF',
                          controller: _cpfController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.datetime,
                          placeholder: 'nascimento',
                          controller: _birthController,
                        ),
                      ),
                      DividerForm(text: 'Dados de Endereço'),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.text,
                          placeholder: 'endereço',
                          controller: _enderecoController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.text,
                          placeholder: 'bairro',
                          controller: _bairroController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.text,
                          placeholder: 'cidade',
                          controller: _cidadeController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.text,
                          placeholder: 'estado',
                          controller: _estadoController,
                        ),
                      ),
                      DividerForm(text: 'Dados de Login'),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Input(
                          readOnly: false,
                          textType: TextInputType.emailAddress,
                          placeholder: 'email',
                          controller: _emailController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
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
                              title: 'confirmar',
                              colors: [0xff004F77, 0xff3DBEFF],
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Cadastrando...'),
                                    ),
                                  );
                                }

                                final Map<String, dynamic> data = {
                                  'name': _nameController.text,
                                  'tel': _telController.text,
                                  'cpf': _cpfController.text,
                                  'birth': _birthController.text,
                                  'adress': {
                                    'endereco': _enderecoController.text,
                                    'bairro': _bairroController.text,
                                    'cidade': _cidadeController.text,
                                    'estado': _estadoController.text,
                                  },
                                  'email': _emailController.text,
                                };
                                final password = _passwordController.text;
                                model.signUp(
                                  data,
                                  password,
                                  () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          'Cadastrado com sucesso!',
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Algo deu errado ao cadastrar, tente novamente!',
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.transparent,
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                  ),
                  child: Text(
                    'Já possui uma conta? Faça o login aqui',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  onPressed:
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
