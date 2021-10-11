// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:rota_segura_app/models/admin.dart';

//screens
import 'package:rota_segura_app/screens/admin/userInfoMarker.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserRoutePage extends StatefulWidget {
  Set<Polyline> _route;
  Set<Marker> _markers;

  UserRoutePage(this._route, this._markers);

  @override
  State<StatefulWidget> createState() => _UserRoutePageState();
}

class _UserRoutePageState extends State<UserRoutePage> {
  final LatLng _initialCamera = const LatLng(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<AdminModel>(builder: (context, child, model) {
        return Container(
            child: GoogleMap(
          onMapCreated: model.onMapCreated,
          polylines: widget._route,
          markers: widget._markers,
          initialCameraPosition: CameraPosition(
            target: _initialCamera,
          ),
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: true,
        ));
      }),
    );
  }
}
