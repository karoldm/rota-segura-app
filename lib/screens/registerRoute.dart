// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
//libraries
import 'package:google_maps_flutter/google_maps_flutter.dart';
//models
import 'package:rota_segura/models/userRouteMap.dart';
import 'package:rota_segura/screens/help.dart';
import 'package:rota_segura/screens/home.dart';
//widgets
import 'package:rota_segura/widgets/button.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterRoutePage extends StatefulWidget {
  @override
  _RegisterRoutePageState createState() => _RegisterRoutePageState();
}

class _RegisterRoutePageState extends State<RegisterRoutePage> {
  final LatLng _initialCamera = const LatLng(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed:
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              ),
        ),
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
      body: ScopedModelDescendant<UserRouteMap>(
        builder: (context, child, model) {
          return Container(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: model.onMapCreated,
                  polylines: model.polyline,
                  initialCameraPosition: CameraPosition(target: _initialCamera),
                  zoomControlsEnabled: false,
                  onTap: (point) {
                    setState(() {
                      model.addPolyline(point: point);
                    });
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Button(
                          title: "confirmar",
                          function: () {
                            if (model.polylinePoints != []) {
                              model.storePolyline(
                                () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: Text("Atualizar rota"),
                                          content: Text(
                                            "Rota atualizada com sucesso!",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) => HomePage(),
                                                  ),
                                                );
                                              },
                                              child: Text("Ok"),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                () {
                                  AlertDialog(
                                    title: Text("Atualização de rota"),
                                    content: Text(
                                      "Algo deu errado ao atuaizar a rota! tente novamente...",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('ok'),
                                        onPressed: () {
                                          setState(() {
                                            model.clearMap();
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          colors: [0xff004F77, 0xff3DBEFF],
                        ),
                        SizedBox(width: 10),
                        Button(
                          title: "cancelar",
                          function: () {
                            model.clearMap();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          colors: [0xffDB0000, 0xffFF7272],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
