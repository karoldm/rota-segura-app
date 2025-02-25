// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
//models
import 'package:rota_segura/models/user.dart';
import 'package:rota_segura/screens/help.dart';
//screens
import 'package:rota_segura/screens/login.dart';
//widgets
import 'package:rota_segura/widgets/button.dart';
import 'package:rota_segura/widgets/input.dart';
import 'package:rota_segura/widgets/inputPassword.dart';
//libraries
import 'package:scoped_model/scoped_model.dart';

class EditPage extends StatefulWidget {
  @override
  EditPageState createState() => EditPageState();
}

//para nao ocorrer entradas vazias o formulario sempre tera um valor inicial (valores atuais), e todos os campos serao obrigatorios

class EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final _formPasswordKey = GlobalKey<FormState>();

  Map<String, dynamic> dataUser = {};
  bool _readOnly = true;
  int _buttonEditColor = 0xff3DBEFF;
  int _buttonPasswordColor = 0xff3DBEFF;
  bool _editScreen = true;

  var _nameController;
  var _telController;
  var _cpfController;
  var _birthController;
  var _enderecoController;
  var _bairroController;
  var _cidadeController;
  var _estadoController;
  var _emailController;

  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();

  void _toggleReadOnly() {
    setState(() {
      _readOnly = !_readOnly;
    });
  }

  void _enabledEditButton() {
    setState(() {
      _buttonEditColor == 0xff3DBEFF
          ? _buttonEditColor = 0xff004F77
          : _buttonEditColor = 0xff3DBEFF;
      _buttonPasswordColor = 0xff3DBEFF;
      _editScreen = true;
    });
  }

  void _enabledPasswordButton() {
    setState(() {
      _editScreen = false;
      _buttonPasswordColor = 0xff004F77;
      _buttonEditColor = 0xff3DBEFF;
      if (_readOnly == false) {
        _readOnly = true;
      }
      _passwordController.text = "";
      _newPasswordController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.getUserData(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              dataUser = snapshot.data!;
              _nameController = TextEditingController(text: dataUser['name']);
              _telController = TextEditingController(text: dataUser['tel']);
              _cpfController = TextEditingController(text: dataUser['cpf']);
              _birthController = TextEditingController(text: dataUser['birth']);
              _enderecoController = TextEditingController(
                text: dataUser['adress']['endereco'],
              );
              _bairroController = TextEditingController(
                text: dataUser['adress']['bairro'],
              );
              _cidadeController = TextEditingController(
                text: dataUser['adress']['cidade'],
              );
              _estadoController = TextEditingController(
                text: dataUser['adress']['estado'],
              );
              _emailController = TextEditingController(text: dataUser['email']);

              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  actions: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: Icon(Icons.help, size: 40.0),
                        color: Color(0xff005783),
                        onPressed:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                //mandando usuário para a página de perfil
                                builder: (context) => HelpPage(),
                              ),
                            ),
                      ),
                    ),
                  ],
                  backgroundColor: Color(0xff3dbeff),
                  title: Text("Rota Segura", style: TextStyle(fontSize: 25)),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Button(
                                title: 'Editar dados',
                                function: () {
                                  _toggleReadOnly();
                                  _enabledEditButton();
                                },
                                colors: [_buttonEditColor, _buttonEditColor],
                              ),
                              SizedBox(width: 10),
                              Button(
                                title: 'Mudar senha',
                                function: () {
                                  _enabledPasswordButton();
                                },
                                colors: [
                                  _buttonPasswordColor,
                                  _buttonPasswordColor,
                                ],
                              ),
                            ],
                          ),
                        ),
                        _editScreen == true ? editForm() : passwordForm(),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }

  Widget passwordForm() {
    return Form(
      key: _formPasswordKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: InputPassword(
              placeholder: 'senha atual',
              controller: _passwordController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: InputPassword(
              placeholder: 'nova senha',
              controller: _newPasswordController,
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
                    if (_formPasswordKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Atualizando senha...')),
                      );
                    }

                    final String password = _passwordController.text;
                    final String newPassword = _newPasswordController.text;

                    model.editPasswordUser(
                      password,
                      newPassword,
                      () {
                        _readOnly = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Senha atualizados com sucesso! Por favor faça o login novamente.',
                            ),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            //mandando usuário para a página de perfil
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Algo deu errado ao atualizar, tente novamente!',
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
    );
  }

  Widget editForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: _readOnly,
              textType: TextInputType.text,
              placeholder: 'nome completo',
              controller: _nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: _readOnly,
              textType: TextInputType.number,
              placeholder: 'telefone',
              controller: _telController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: _readOnly,
              textType: TextInputType.datetime,
              placeholder: 'nascimento',
              controller: _birthController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: true,
              textType: TextInputType.number,
              placeholder: 'CPF',
              controller: _cpfController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: true,
              textType: TextInputType.emailAddress,
              placeholder: 'email',
              controller: _emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: _readOnly,
              textType: TextInputType.text,
              placeholder: 'endereço',
              controller: _enderecoController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: _readOnly,
              textType: TextInputType.text,
              placeholder: 'bairro',
              controller: _bairroController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: _readOnly,
              textType: TextInputType.text,
              placeholder: 'cidade',
              controller: _cidadeController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Input(
              readOnly: _readOnly,
              textType: TextInputType.text,
              placeholder: 'estado',
              controller: _estadoController,
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
                        const SnackBar(content: Text('Atualizando dados...')),
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

                    model.editUser(
                      data,
                      () {
                        _readOnly = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Dados atualizados com sucesso!'),
                          ),
                        );
                      },
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Algo deu errado ao atualizar, tente novamente!',
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
    );
  }
}
