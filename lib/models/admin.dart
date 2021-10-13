// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'dart:convert';

//libraries
import 'package:scoped_model/scoped_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

//firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminModel extends Model {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  late BitmapDescriptor customIcon;
  late GoogleMapController _mapController;
  Location _location = Location();

  Set<Polyline> route = {};
  Set<Marker> markers = {};

  List<LatLng> _polylinePoints = [];
  int _markersIdCount = 1;
  String _enabledMarker = " ";

  AdminModel() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(12, 12)), 'images/iconMarker.png')
        .then((d) {
      customIcon = d;
    });
  }

  Future<Iterable> getCalls() async {
    Iterable calls = [];

    final documents = await _db.collection('chamadas').get();
    calls = documents.docs.map((doc) => doc.data());
    return calls;
  }

  void closeCall(
      String id, VoidCallback? success(), VoidCallback? fail()) async {
    await _db.collection('chamadas').doc(id).delete().then((value) {
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

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

  void getUserRoute(String points, VoidCallback? callback()) {
    this.route.clear();
    this.markers.clear();
    this._polylinePoints.clear();
    String markerId;
    List listCoordinates = json.decode(points);
    listCoordinates.forEach((coordinate) {
      markerId = 'marker_id_$_markersIdCount';
      _markersIdCount++;
      markers.add(Marker(
          icon: this.customIcon,
          markerId: MarkerId(markerId),
          position: LatLng(coordinate[0], coordinate[1]),
          onTap: () {
            _enabledMarker = [coordinate[0], coordinate[1]].toString();
            callback();
          }));
      _polylinePoints.add(LatLng(coordinate[0], coordinate[1]));
    });

    route.add(Polyline(
        polylineId: PolylineId('polyline_id_1'),
        color: Colors.black,
        width: 2,
        points: _polylinePoints));
  }

  Future<Map<String, dynamic>> getUserInfo(
      String userId, Map<String, dynamic> textMarkers) async {
    Map<String, dynamic> infos = {};

    String text = '';

    if (textMarkers.containsKey(this._enabledMarker.toString())) {
      text = textMarkers[this._enabledMarker.toString()];
      print(text);
    }
    infos['text'] = text;

    //get image
    await _storage
        .ref('$userId/image-${this._enabledMarker}')
        .getDownloadURL()
        .then((url) {
      infos['url'] = url;
    }).catchError((e) {
      print(e);
      infos['url'] = null;
    });

    return infos;
  }
}
