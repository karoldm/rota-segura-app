import 'package:flutter/material.dart';

//libraries
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  bool _onTapMap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                markers: model.markers,
                polylines: model.polyline,
                initialCameraPosition: CameraPosition(
                  target: _initialCamera,
                ),
                zoomControlsEnabled: false,
                onTap: (point) {
                  setState(() {
                    model.addPolyline(point);
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
                                print("armazenado");
                              }, () {
                                print("falhou");
                              });
                            }
                          },
                          colors: [0xff004F77, 0xff3DBEFF]),
                      SizedBox(
                        width: 10,
                      ),
                      Button(
                          title: "deletar rota",
                          function: () {},
                          colors: [0xffDB0000, 0xffFF7272]),
                    ],
                  ),
                ))
          ]));
        }));
  }
}
