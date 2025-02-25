// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//models
import 'package:rota_segura/models/admin.dart';
import 'package:rota_segura/screens/admin/userInfoMarker.dart';
//screens
import 'package:rota_segura/screens/admin/userRoute.dart';
//widgets
import 'package:rota_segura/widgets/button.dart';
//librearies
import 'package:scoped_model/scoped_model.dart';

class CardWidget extends StatefulWidget {
  final _data;
  final VoidCallback _updatePage;

  @override
  State<StatefulWidget> createState() => _CardWidgetState();

  CardWidget(this._data, this._updatePage);
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    final _name = widget._data['name'];
    final _adress = widget._data['adress'];
    final _tel = widget._data['tel'];
    final _cpf = widget._data['cpf'];
    final _birth = widget._data['birth'];

    final _id = widget._data['id'];

    final _textMarkers = widget._data['textMarkers'] as Map<String, dynamic>;

    final _date = widget._data['date'];

    return ScopedModelDescendant<AdminModel>(
      builder: (context, child, adminModel) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            color: Color(0xff005783),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat(" dd/MM/yyyy  HH:mm").format(
                        DateTime.fromMicrosecondsSinceEpoch(
                          _date.microsecondsSinceEpoch,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        height: 1.8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Nome: $_name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.8,
                    ),
                  ),
                  Text(
                    'CPF: $_cpf',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.8,
                    ),
                  ),
                  Text(
                    'Data de Nascimento: $_birth',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.8,
                    ),
                  ),
                  Text(
                    'Endereço: ${_adress['endereco']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.8,
                    ),
                  ),
                  Text(
                    'Bairro: ${_adress['bairro']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.8,
                    ),
                  ),
                  Text(
                    'Cidade: ${_adress['cidade']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.8,
                    ),
                  ),
                  Text(
                    'Estado: ${_adress['estado']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.8,
                    ),
                  ),
                  Text(
                    'Telefone: $_tel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Button(
                      title: "visualizar rota",
                      function: () {
                        adminModel.getUserRoute(widget._data['route'], () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      UserInfoMarker(_textMarkers, _id),
                            ),
                          );
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserRoutePage(),
                          ),
                        );
                      },
                      colors: [0xffDB0000, 0xffFF7272],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Button(
                      title: "finalizar chamada",
                      function: () {
                        adminModel.closeCall(
                          _id,
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Chamada finalizada com sucesso!',
                                ),
                              ),
                            );
                            widget._updatePage();
                          },
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Algo deu errado ao encerrar essa chamada! Tente novamente...',
                                ),
                              ),
                            );
                          },
                        );
                      },
                      colors: [0xffDB0000, 0xffFF7272],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
