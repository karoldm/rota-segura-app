// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:rota_segura_app/widgets/divider.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';

//models
import 'package:rota_segura_app/models/admin.dart';

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
            backgroundColor: Colors.transparent,
            title: Text(
              "Informações do local",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Color(0xff005783),
          body: Container(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "Aqui é possível visualizar informações como descrição e imagens do local adicionadas por quem está solicitando ajuda!",
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    FutureBuilder(
                        future: adminModel.getUserInfo(_userId, _textMarkers),
                        builder: (context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: Text(
                                      snapshot.data!['text'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    ),
                                  ),
                                  snapshot.data!['url'] != null
                                      ? Image(
                                          image: NetworkImage(
                                              snapshot.data!['url']))
                                      : Container()
                                ],
                              ),
                            );
                          }
                          return Container();
                        })

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
                  ]))));
    });
  }
}
