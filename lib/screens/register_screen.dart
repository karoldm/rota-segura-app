import 'package:flutter/material.dart';
import 'package:rota_segura_app/screens/profile_screen.dart';
import 'package:rota_segura_app/widgets/appName_widget.dart';
import 'package:rota_segura_app/widgets/button_widget.dart';
import 'package:rota_segura_app/widgets/inputPassword_widget.dart';
import 'package:rota_segura_app/widgets/input_widget.dart';
import 'package:scoped_model/scoped_model.dart';

//my_app
import 'package:rota_segura_app/screens/login_screen.dart';
import 'package:rota_segura_app/models/user_model.dart';

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
                      'Preencha os campos com seus dados',
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
                      placeholder: 'nome completo',
                      controller: _nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      placeholder: 'telefone',
                      controller: _telController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      placeholder: 'CPF',
                      controller: _cpfController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      placeholder: 'nascimento',
                      controller: _birthController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      placeholder: 'endereço',
                      controller: _enderecoController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      placeholder: 'bairro',
                      controller: _bairroController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      placeholder: 'cidade',
                      controller: _cidadeController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      placeholder: 'estado',
                      controller: _estadoController,
                    ),
                  ),
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
                            title: 'confirmar',
                            function: () {
                              Map<String, dynamic> data = {
                                'name': _nameController.text,
                                'tel': _telController.text,
                                'cpf': _cpfController.text,
                                'birth': _birthController.text,
                                'adress': {
                                  'endereco': _enderecoController.text,
                                  'bairro': _bairroController,
                                  'cidade': _cidadeController,
                                  'estado': _estadoController
                                },
                                'email': _emailController.text,
                              };
                              final password = _passwordController.text;
                              model.signUp(data, password, () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
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
                  'Já possui uma conta? Faça o login aqui',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()))))
      ],
    ))));
  }
}
