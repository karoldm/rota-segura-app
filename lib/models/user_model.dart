import 'package:flutter/material.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';

//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  late UserCredential? _userCredential;
  late Map<String, dynamic>
      userData; //dados do usuario para compartilhar com outras telas

  void signUp(Map<String, dynamic> data, String password,
      VoidCallback? success(), VoidCallback? fail()) {
    _auth
        .createUserWithEmailAndPassword(
            email: data['email'], password: password)
        .then((value) async {
      await _db.collection('users').doc(value.user!.uid).set(data);
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

  void signIn(String email, String password, VoidCallback? success(),
      VoidCallback? fail()) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _userCredential = value;
      _currentUser();
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

  void signOut(VoidCallback? success()) {
    _auth.signOut();
    _userCredential = null;
    userData = {};
    success();
  }

  Future<Null> _currentUser() async {
    final currentUser =
        await _db.collection('users').doc(_userCredential!.user!.uid).get();
    userData = currentUser.data()!;
  }
}
