// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

//models
import 'package:rota_segura_app/models/admin.dart';
import 'package:rota_segura_app/models/userRouteMap.dart';
import 'package:rota_segura_app/screens/admin/userInfoMarker.dart';
import 'package:rota_segura_app/screens/admin/userRoute.dart';

//librearies
import 'package:scoped_model/scoped_model.dart';

//widgets
import 'package:rota_segura_app/widgets/button.dart';

class CardWidget extends StatefulWidget {
  final _data;
  VoidCallback _updatePage;

  @override
  State<StatefulWidget> createState() => _CardWidgetState();

  CardWidget(this._data, this._updatePage);
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    final name = widget._data['name'];
    final adress = widget._data['adress'];
    final tel = widget._data['tel'];
    final cpf = widget._data['cpf'];
    final birth = widget._data['birth'];

    final id = widget._data['id'];

    return ScopedModelDescendant<AdminModel>(
        builder: (context, child, adminModel) {
      return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Color(0xff005783),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "10-10-2021    22:23h",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              height: 1.8,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Nome: $name',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0, height: 1.8),
                      ),
                      Text(
                        'CPF: $cpf',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0, height: 1.8),
                      ),
                      Text(
                        'Data de Nascimento: $birth',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0, height: 1.8),
                      ),
                      Text(
                        'Endereço: ${adress['endereco']}',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0, height: 1.8),
                      ),
                      Text(
                        'Bairro: ${adress['bairro']}',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0, height: 1.8),
                      ),
                      Text(
                        'Cidade: ${adress['cidade']}',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0, height: 1.8),
                      ),
                      Text(
                        'Estado: ${adress['estado']}',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0, height: 1.8),
                      ),
                      Text(
                        'Telefone: $tel',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16.0, height: 1.8),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Button(
                              title: "visualizar rota",
                              function: () {},
                              colors: [0xffDB0000, 0xffFF7272])),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Button(
                              title: "finalizar chamada",
                              function: () {
                                adminModel.closeCall(id, () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              'Chamada finalizada com sucesso!')));
                                  widget._updatePage();
                                }, () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'Algo deu errado ao encerrar essa chamada! Tente novamente...')));
                                });
                              },
                              colors: [0xffDB0000, 0xffFF7272]))
                    ],
                  ))));
    });
  }
}
