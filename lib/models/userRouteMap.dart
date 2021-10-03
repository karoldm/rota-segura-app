import 'package:flutter/material.dart';
import 'dart:convert';

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

  String? enabledMarker;

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

  void addPolyline({LatLng? point}) {
    if (point != null) polylinePoints.add(point);
    this.polyline.add(Polyline(
        polylineId: PolylineId(this._polylineId),
        color: Colors.black,
        width: 2,
        points: this.polylinePoints));
  }

  void _addMarker(LatLng position, VoidCallback? enableModal()) {
    final String markerId = 'marker_id_${this._markersIdCount}';
    this._markersIdCount++;
    this.markers.add(Marker(
        markerId: MarkerId(markerId),
        position: position,
        onTap: () {
          this.enabledMarker =
              [position.latitude, position.longitude].toString();
          enableModal();
        }));
    polylinePoints.add(position);
  }

  void storePolyline(VoidCallback? success(), VoidCallback? fail()) async {
    final user = _auth.currentUser;
    await _db
        .collection('users')
        .doc(user!.uid)
        .update({"route": json.encode(this.polylinePoints)}).then((value) {
      clearMap();
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

  Future<Set<Polyline>> getPolyline(VoidCallback? enableModal()) async {
    final user = _auth.currentUser;
    Map<String, dynamic> data = {};
    await _db.collection('users').doc(user!.uid).get().then((value) {
      data = value.data()!;
    }).catchError((e) {
      print(e);
    });

    try {
      List listCoordinates = json.decode(data['route']);
      clearMap();
      listCoordinates.forEach((coordinate) {
        _addMarker(LatLng(coordinate[0], coordinate[1]), enableModal);
      });
      addPolyline();
    } catch (e) {
      print(e);
    }
    return this.polyline;
  }

  void clearMap() {
    this.polyline.clear();
    this.markers.clear();
    this.polylinePoints.clear();
  } //recebe a latLng como key

  void createInfoMarker(
      VoidCallback? success(), VoidCallback? fail(), String text) async {
    final user = _auth.currentUser;

    Map<String, dynamic> data = {};
    List? infoMap = [];

    await _db.collection('users').doc(user!.uid).get().then((value) {
      data = value.data()!;
    }).catchError((e) {
      print(e);
    });

    try {
      bool contains = false;
      infoMap = json.decode(data['markersInfo']);
      if (infoMap != null) {
        infoMap.forEach((info) {
          if (info.containsKey(this.enabledMarker)) {
            info[this.enabledMarker] = {this.enabledMarker.toString(): text};
            contains = true;
          }
        });
        if (contains == false) {
          infoMap.add({this.enabledMarker.toString(): text});
        }
      } else {
        infoMap = [
          {this.enabledMarker: text}
        ];
      }
    } catch (e) {
      print(e);
    }

    await _db
        .collection('users')
        .doc(user.uid)
        .update({'markersInfo': json.encode(infoMap)}).then((value) {
      clearMap();
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

  Future<String> getTextInfoMarker() async {
    final user = _auth.currentUser;
    Map<String, dynamic> data = {};
    String textInfo = "";

    await _db.collection('users').doc(user!.uid).get().then((value) {
      data = value.data()!;
    }).catchError((e) {
      print(e);
    });

    try {
      List infoMap = json.decode(data['markersInfo']);
      infoMap.forEach((info) {
        if (info.containsKey(this.enabledMarker))
          textInfo = info[this.enabledMarker];
      });
    } catch (e) {
      print(e);
    }

    return textInfo;
  }

  /*

  void editInfoMarker(LatLng latLng, String infoText /*Imagem?*/){}


  void deleteInfoMarker(){}
  */
}
