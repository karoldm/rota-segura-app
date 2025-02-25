// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
//models
import 'package:rota_segura/models/admin.dart';
import 'package:rota_segura/screens/admin/help.dart';
import 'package:rota_segura/widgets/divider.dart';
//libraries
import 'package:scoped_model/scoped_model.dart';

class UserInfoMarker extends StatelessWidget {
  final Map<String, dynamic> _textMarkers;
  final _userId;

  UserInfoMarker(this._textMarkers, this._userId);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AdminModel>(
      builder: (context, child, adminModel) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
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
                    Navigator.pushReplacement(
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
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                  child: Text(
                    "Aqui é possível visualizar informações como descrição e imagens do local adicionadas por quem está solicitando ajuda!",
                    style: TextStyle(fontSize: 17.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
                FutureBuilder(
                  future: adminModel.getUserInfo(_userId, _textMarkers),
                  builder: (
                    context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            DividerForm(text: 'Descrição do local'),
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text(
                                snapshot.data!['text'],
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            DividerForm(text: 'Imagem do local'),
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child:
                                  snapshot.data!['url'] != null
                                      ? Image(
                                        image: NetworkImage(
                                          snapshot.data!['url'],
                                        ),
                                      )
                                      : Container(),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),

                /*FutureBuilder(
                      future: model,
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 30.0, 0, 10.0),
                              child: Image(
                                  image:
                                      NetworkImage(snapshot.data.toString())));
                        } else {
                          return Container();
                        }
                      }),*/
              ],
            ),
          ),
        );
      },
    );
  }
}
