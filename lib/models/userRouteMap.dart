import 'dart:convert';

import 'package:flutter/material.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRouteMap extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  late GoogleMapController _mapController;
  Location _location = Location();

  Set<Marker> markers = {};
  int _markersIdCount = 1;

  Set<Polyline> polyline = {};
  final String _polylineId = 'polyline_id_1';
  List<LatLng> polylinePoints = [];

  void onMapCreated(GoogleMapController controller) {
    this._mapController = controller;
    this._location.onLocationChanged.listen((l) {
      this._mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(l.latitude!, l.longitude!), zoom: 15),
            ),
          );
    });
  }

  void addPolyline({LatLng? marker}) {
    if (marker != null) _addMarker(marker);
    this.polyline.add(Polyline(
        polylineId: PolylineId(this._polylineId),
        color: Colors.black,
        width: 2,
        points: this.polylinePoints));
  }

  void _addMarker(LatLng position) {
    final String markerId = 'marker_id_${this._markersIdCount}';
    this._markersIdCount++;
    this.markers.add(Marker(markerId: MarkerId(markerId), position: position));
    polylinePoints.add(position);
    //ontap event on marker
  }

  void storePolyline(VoidCallback? success(), VoidCallback? fail()) async {
    final user = _auth.currentUser;
    await _db
        .collection('users')
        .doc(user!.uid)
        .update({"route": json.encode(this.polylinePoints)}).then((value) {
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

  Future<Set<Polyline>> getPolyline() async {
    final user = _auth.currentUser;
    Map<String, dynamic> data = {};
    await _db.collection('users').doc(user!.uid).get().then((value) {
      data = value.data()!;
    }).catchError((e) {
      print(e);
    });

    try {
      List listCoordinates = json.decode(data['route']);
      this.polylinePoints = [];
      listCoordinates.forEach((coordinate) {
        this.polylinePoints.add(LatLng(coordinate[0], coordinate[1]));
      });
      addPolyline();
    } catch (err) {
      print(err);
    }
    return this.polyline;
  }

  /*
  Polyline getPolyline(){} //array de latLng para desenhar a rota

  void deletePolyline(){}

  void createInfoMarker(LatLng latLng, String infoText /*Imagem?*/){} //recebe a latLng como key

  void editInfoMarker(LatLng latLng, String infoText /*Imagem?*/){}

  Map<LatLng, dynamic> getInfoMarker(){}

  void deleteInfoMarker(){}*/
}
