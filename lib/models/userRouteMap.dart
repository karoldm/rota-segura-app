// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

//libraries
import 'package:scoped_model/scoped_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';

//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRouteMap extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  late GoogleMapController _mapController;
  Location _location = Location();

  String? enabledMarker;

  Set<Marker> markers = {};
  int _markersIdCount = 1;

  Set<Polyline> polyline = {};
  final String _polylineId = 'polyline_id_1';
  List<LatLng> polylinePoints = [];

  late BitmapDescriptor customIcon;

  UserRouteMap() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(12, 12)), 'images/iconMarker.png')
        .then((d) {
      customIcon = d;
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
        icon: customIcon,
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
  }

  void createInfoMarker(
      VoidCallback? success(), VoidCallback? fail(), String text) async {
    final user = _auth.currentUser;

    Map<String, dynamic> data = {};
    Map<String, dynamic> textMarkers = {};

    await _db.collection('users').doc(user!.uid).get().then((value) {
      data = value.data()!;
    }).catchError((e) {
      print(e);
    });

    if (data.containsKey("textMarkers")) {
      textMarkers = data["textMarkers"];
    }

    textMarkers[this.enabledMarker!.toString()] = text;

    await _db
        .collection('users')
        .doc(user.uid)
        .update({"textMarkers": textMarkers}).then((value) {
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
    Map<String, dynamic> textMarkers = {};
    String text = "";

    await _db.collection('users').doc(user!.uid).get().then((value) {
      data = value.data()!;
    }).catchError((e) {
      print(e);
    });

    if (data.containsKey("textMarkers")) {
      textMarkers = data["textMarkers"];
      if (textMarkers.containsKey(this.enabledMarker.toString())) {
        text = textMarkers[this.enabledMarker.toString()];
      }
    }

    return text;
  }

  Future<void> uploadImage(String inputSource, VoidCallback? upload()) async {
    final user = _auth.currentUser;

    final picker = ImagePicker();
    XFile? pickedImage;

    pickedImage = await picker.pickImage(
        source:
            inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery);

    File imageFile = File(pickedImage!.path);

    await _storage
        .ref('${user!.uid}/image-${this.enabledMarker}')
        .putFile(imageFile)
        .then((value) => upload());
  }

  Future<String> getImage() async {
    final user = _auth.currentUser;

    String url = await _storage
        .ref('${user!.uid}/image-${this.enabledMarker}')
        .getDownloadURL();

    return url;
  }
}
