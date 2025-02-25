// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
//models
import 'package:rota_segura/models/admin.dart';
import 'package:rota_segura/models/user.dart';
//screens
import 'package:rota_segura/screens/admin/help.dart';
import 'package:rota_segura/screens/login.dart';
//widgets
import 'package:rota_segura/widgets/card.dart';
//libraries
import 'package:scoped_model/scoped_model.dart';

class AdminHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, userModel) {
        return ScopedModelDescendant<AdminModel>(
          builder: (context, child, adminModel) {
            return Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder:
                      (conext) => IconButton(
                        onPressed: () {
                          userModel.logout(
                            () {
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
                                  content: Text('Erro ao sair!'),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.logout, size: 30),
                      ),
                ),
                backgroundColor: Color(0xff3dbeff),
                title: Text("Rota Segura", style: TextStyle(fontSize: 25)),
                centerTitle: true,
                actions: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: IconButton(
                      icon: Icon(Icons.help, size: 40.0),
                      color: Color(0xff005783),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //mandando usuário para a página de perfil
                            builder: (context) => AdminHelpPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              body: FutureBuilder(
                future: adminModel.getCalls(),
                builder: (context, AsyncSnapshot<Iterable> snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> cards = [];
                    snapshot.data!.forEach((element) {
                      cards.add(
                        CardWidget(element as Map, () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminHome(),
                            ),
                          );
                        }),
                      );
                    });
                    return ListView(children: [for (var item in cards) item]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
