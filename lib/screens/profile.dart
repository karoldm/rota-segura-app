import 'package:flutter/material.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';

//models
import 'package:rota_segura_app/models/user.dart';

//screens
import 'package:rota_segura_app/screens/login.dart';
import 'package:rota_segura_app/screens/home.dart';

//widgets
import 'package:rota_segura_app/widgets/appName.dart';
import 'package:rota_segura_app/widgets/button.dart';
import 'package:rota_segura_app/widgets/inputPassword.dart';
import 'package:rota_segura_app/widgets/input.dart';

class EditPage extends StatefulWidget {
  @override
  EditPageState createState() => EditPageState();
}

//para nao ocorrer entradas vazias o formulario sempre tera um valor inicial (valores atuais), e todos os campos serao obrigatorios

class EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> dataUser = {};

  var _nameController;
  var _telController;
  var _cpfController;
  var _birthController;
  var _enderecoController;
  var _bairroController;
  var _cidadeController;
  var _estadoController;
  var _emailController;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return FutureBuilder(
          future: model.getUserData(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              dataUser = snapshot.data!;
              _nameController = TextEditingController(text: dataUser['name']);
              _telController = TextEditingController(text: dataUser['tel']);
              _cpfController = TextEditingController(text: dataUser['cpf']);
              _birthController = TextEditingController(text: dataUser['birth']);
              _enderecoController =
                  TextEditingController(text: dataUser['adress']['endereco']);
              _bairroController =
                  TextEditingController(text: dataUser['adress']['bairro']);
              _cidadeController =
                  TextEditingController(text: dataUser['adress']['cidade']);
              _estadoController =
                  TextEditingController(text: dataUser['adress']['estado']);
              _emailController = TextEditingController(text: dataUser['email']);

              return Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    actions: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.help,
                          color: Color(0xff005783),
                          size: 40,
                        ),
                      ),
                    ],
                    title: Text(
                      "Rota Segura",
                      style: TextStyle(fontSize: 25),
                    ),
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
                                      function: () => null,
                                      colors: [0xff3DBEFF, 0xff3DBEFF]),
                                  SizedBox(width: 10),
                                  Button(
                                      title: 'Mudar senha',
                                      function: () => null,
                                      colors: [0xff3DBEFF, 0xff3DBEFF])
                                ],
                              )),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Input(
                                          textType: TextInputType.text,
                                          placeholder: 'nome completo',
                                          controller: _nameController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Input(
                                          textType: TextInputType.number,
                                          placeholder: 'telefone',
                                          controller: _telController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Input(
                                          textType: TextInputType.datetime,
                                          placeholder: 'nascimento',
                                          controller: _birthController,
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 30, 0, 0),
                                          child: TextFormField(
                                              validator: (value) {
                                                //verificando se o campo foi preenchido
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Esse campo precisa ser preenchido';
                                                }
                                                return null;
                                              },
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                              readOnly: true,
                                              keyboardType: TextInputType
                                                  .number, //tipo do teclado
                                              cursorColor: Colors.black,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              controller: _cpfController,
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  hintText: 'CPF',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6))))),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 30, 0, 0),
                                          child: TextFormField(
                                              validator: (value) {
                                                //verificando se o campo foi preenchido
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Esse campo precisa ser preenchido';
                                                }
                                                return null;
                                              },
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                              readOnly: true,
                                              keyboardType: TextInputType
                                                  .emailAddress, //tipo do teclado
                                              cursorColor: Colors.black,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              controller: _emailController,
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  hintText: 'email',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6))))),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Input(
                                          textType: TextInputType.text,
                                          placeholder: 'endereço',
                                          controller: _enderecoController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Input(
                                          textType: TextInputType.text,
                                          placeholder: 'bairro',
                                          controller: _bairroController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Input(
                                          textType: TextInputType.text,
                                          placeholder: 'cidade',
                                          controller: _cidadeController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                        child: Input(
                                          textType: TextInputType.text,
                                          placeholder: 'estado',
                                          controller: _estadoController,
                                        ),
                                      ),
                                      ScopedModelDescendant<UserModel>(
                                          builder: (context, child, model) {
                                        return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: Button(
                                                title: 'confirmar',
                                                colors: [
                                                  0xff004F77,
                                                  0xff3DBEFF
                                                ],
                                                function: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Atualizando dados...')),
                                                    );
                                                  }

                                                  final Map<String, dynamic>
                                                      data = {
                                                    'name':
                                                        _nameController.text,
                                                    'tel': _telController.text,
                                                    'cpf': _cpfController.text,
                                                    'birth':
                                                        _birthController.text,
                                                    'adress': {
                                                      'endereco':
                                                          _enderecoController
                                                              .text,
                                                      'bairro':
                                                          _bairroController
                                                              .text,
                                                      'cidade':
                                                          _cidadeController
                                                              .text,
                                                      'estado':
                                                          _estadoController.text
                                                    },
                                                    'email':
                                                        _emailController.text,
                                                  };

                                                  model.editUser(data, () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                content: Text(
                                                                    'Dados atualizados com sucesso!')));
                                                  }, () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          content: Text(
                                                              'Algo deu errado ao atualizar, tente novamente!')),
                                                    );
                                                  });
                                                }));
                                      })
                                    ],
                                  )),
                            ],
                          ))));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
