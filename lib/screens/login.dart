import 'package:flutter/material.dart';

//widgets
import 'package:rota_segura_app/widgets/appName.dart';
import 'package:rota_segura_app/widgets/button.dart';
import 'package:rota_segura_app/widgets/inputPassword.dart';
import 'package:rota_segura_app/widgets/input.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';

//models
import 'package:rota_segura_app/models/user.dart';

//screens
import 'package:rota_segura_app/screens/home.dart';
import 'package:rota_segura_app/screens/register.dart';

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
        //rolagem da página
        body: SingleChildScrollView(
            child: Container(
                child: Column(
      children: <Widget>[
        Container(
          //header com nome do app
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff004F77), Color(0xff3DBEFF)])),
          child: Column(
            children: <Widget>[
              AppName(), //nome do app
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
          //container para o formulário
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    //email input
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Input(
                      textType: TextInputType.emailAddress,
                      placeholder: 'email',
                      controller: _emailController,
                    ),
                  ),
                  Padding(
                    //password input
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
                            colors: [0xff004F77, 0xff3DBEFF],
                            //função passada para onPressed do button
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                //mensagem de retorno para o usuário
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Entrando...')),
                                );
                              }
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              //função de login
                              model.signIn(email, password, () {
                                //função sucesso do login
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        //mandando usuário para a página de perfil
                                        builder: (context) => HomePage()));
                              }, () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'Algo deu errado ao entrar! Tente novamente...')),
                                );
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
                onPressed: () => Navigator.push(
                    context,
                    //enviando usuário para a página de registro
                    MaterialPageRoute(builder: (context) => RegisterPage()))))
      ],
    ))));
  }
}
