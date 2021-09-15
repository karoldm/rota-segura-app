import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  void onMapCreated(GoogleMapController controller) {
    this._mapController = controller;
    _location.onLocationChanged.listen((l) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  /*final LatLng _lastLatLgn;

  void createRoute(LatLng latLng) {}

  void editRoute(LatLng latLng){}

  Polyline getRoute(){} //array de latLng para desenhar a rota

  void deleteRoute(){}

  void createInfoMarker(LatLng latLng, String infoText /*Imagem?*/){} //recebe a latLng como key

  void editInfoMarker(LatLng latLng, String infoText /*Imagem?*/){}

  Map<LatLng, dynamic> getInfoMarker(){}

  void deleteInfoMarker(){}*/
}
