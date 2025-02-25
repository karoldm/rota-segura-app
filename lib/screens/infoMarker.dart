// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:rota_segura/models/userRouteMap.dart';
import 'package:rota_segura/screens/help.dart';
//widgets
import 'package:rota_segura/widgets/button.dart';
import 'package:rota_segura/widgets/divider.dart';
//model
import 'package:scoped_model/scoped_model.dart';

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
                              builder: (context) => HelpPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                body: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Utilize esse espaço para adicionar uma imagem e uma descrição do local definido pelo marcador (você pode indicar pontos de referências ou alguma característica que ajude a indentificar o local). Essas informações podem agilizar a chagada de ajuda até você! \n*Ao carregar uma imagem ela será automaticamente salva, mesmo que você cancele a operação!",
                            style: TextStyle(fontSize: 17.0),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        DividerForm(text: 'Descrição do local'),
                        Container(
                          padding: const EdgeInsets.only(top: 50.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: TextField(
                            minLines: 8,
                            maxLines: 100,
                            controller: _textController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Insira aqui uma descrição do local",
                            ),
                          ),
                        ),
                        DividerForm(text: 'Imagem do local'),
                        Container(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: FutureBuilder(
                            future: mapModel.getImage(),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    30.0,
                                    0,
                                    10.0,
                                  ),
                                  child: Image(
                                    image: NetworkImage(snapshot.data!),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 10.0),
                          child: Button(
                            title: "adicionar imagem",
                            function: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      content: Text(
                                        "Adicionar uma imagem",
                                        style: TextStyle(fontSize: 18.0),
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(
                                                  0xff3DBEFF,
                                                ),
                                                elevation: 0,
                                              ),
                                              onPressed: () {
                                                mapModel.uploadImage(
                                                  'camera',
                                                  () {
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                              child: Text(
                                                "Camêra",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                mapModel.uploadImage(
                                                  'galeria',
                                                  () {
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(
                                                  0xff004F77,
                                                ),
                                                elevation: 0,
                                              ),
                                              child: Text(
                                                "Galeria",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                              );
                            },
                            colors: [0xff8E8A8A, 0xff8E8A8A],
                          ),
                        ),
                        Button(
                          title: "confirmar",
                          function:
                              () => mapModel.createInfoMarker(
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Informações atualizadas com sucesso!',
                                      ),
                                    ),
                                  );
                                },
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Algo deu errado ao atualizar as informações! tente novamente...',
                                      ),
                                    ),
                                  );
                                },
                                _textController.text,
                              ),
                          colors: [0xffDB0000, 0xffFF5858],
                        ),
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
}
