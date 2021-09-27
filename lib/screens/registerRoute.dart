import 'package:flutter/material.dart';

//libraries
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rota_segura_app/screens/home.dart';
import 'package:scoped_model/scoped_model.dart';

//models
import 'package:rota_segura_app/models/userRouteMap.dart';

//widgets
import 'package:rota_segura_app/widgets/button.dart';

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
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
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
          backgroundColor: Color(0xff3dbeff),
          title: Text(
            "Rota Segura",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserRouteMap>(
            builder: (context, child, model) {
          return Container(
              child: Stack(children: <Widget>[
            GoogleMap(
                onMapCreated: model.onMapCreated,
                polylines: model.polyline,
                initialCameraPosition: CameraPosition(
                  target: _initialCamera,
                ),
                zoomControlsEnabled: false,
                onTap: (point) {
                  setState(() {
                    model.addPolyline(marker: point);
                  });
                }),
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
                              model.storePolyline(() {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Atualizar rota"),
                                          content: Text(
                                              "Rota atualizada com sucesso!"),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage()));
                                                },
                                                child: Text("Ok"))
                                          ],
                                        ));
                              }, () {
                                AlertDialog(
                                    title: Text("Atualização de rota"),
                                    content: Text(
                                        "Algo deu errado ao atuaizar a rota! tente novamente..."),
                                    actions: <Widget>[
                                      TextButton(
                                          child: const Text('ok'),
                                          onPressed: () {
                                            setState(() {
                                              model.clearMap();
                                            });
                                          })
                                    ]);
                              });
                            }
                          },
                          colors: [0xff004F77, 0xff3DBEFF]),
                      SizedBox(
                        width: 10,
                      ),
                      Button(
                          title: "cancelar",
                          function: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          colors: [0xffDB0000, 0xffFF7272]),
                    ],
                  ),
                ))
          ]));
        }));
  }
}
