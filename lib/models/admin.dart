// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'dart:convert';

//libraries
import 'package:scoped_model/scoped_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

//firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel extends Model {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Iterable> getCalls() async {
    Iterable calls = [];

    final documents = await _db.collection('chamadas').get();
    calls = documents.docs.map((doc) => doc.data());
    return calls;
  }
}
