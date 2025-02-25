// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//models
import 'package:rota_segura/models/admin.dart';
//screens
import 'package:rota_segura/screens/admin/help.dart';
import 'package:rota_segura/screens/admin/home.dart';
//libraries
import 'package:scoped_model/scoped_model.dart';

class UserRoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserRoutePageState();
}

class _UserRoutePageState extends State<UserRoutePage> {
  final LatLng _initialCamera = const LatLng(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed:
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminHome()),
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
                      builder: (context) => AdminHelpPage(),
                    ),
                  ),
            ),
          ),
        ],
        backgroundColor: Color(0xff3dbeff),
        title: Text("Rota Segura", style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<AdminModel>(
        builder: (context, child, model) {
          return Container(
            child: GoogleMap(
              onMapCreated: model.onMapCreated,
              polylines: model.route,
              markers: model.markers,
              initialCameraPosition: CameraPosition(target: _initialCamera),
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: true,
            ),
          );
        },
      ),
    );
  }
}
