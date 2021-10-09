// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

import 'package:rota_segura_app/models/userRouteMap.dart';

//model
import 'package:scoped_model/scoped_model.dart';

//widgets
import 'package:rota_segura_app/widgets/button.dart';

class InfoMarker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoMarkerState();
}

class _InfoMarkerState extends State<InfoMarker> {
  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserRouteMap>(
        builder: (context, child, mapModel) {
      return FutureBuilder(
          future: mapModel.getTextInfoMarker(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              _textController = TextEditingController(text: snapshot.data);

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
                    padding: const EdgeInsets.all(30),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Utilize esse espaço para adicionar uma imagem e uma descrição do local definido pelo marcador (você pode indicar pontos de referências ou alguma característica que ajude a indentificar o local). Essas informações podem agilizar a chagada de ajuda até você!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              )),
                          child: TextField(
                            minLines: 8,
                            maxLines: 100,
                            controller: _textController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Insira aqui uma descrição do local"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 10.0),
                          child: Button(
                              title: "adicionar imagem",
                              function: () {},
                              colors: [0xff8E8A8A, 0xff8E8A8A]),
                        ),
                        Button(
                            title: "confirmar",
                            function: () => mapModel.createInfoMarker(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              'Informações atualizadas com sucesso!')));
                                }, () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'Algo deu errado ao atualizar as informações! tente novamente...')));
                                }, _textController.text),
                            colors: [0xffDB0000, 0xffFF5858]),
                      ],
                    ),
                  )));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
