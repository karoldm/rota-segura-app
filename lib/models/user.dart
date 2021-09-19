import 'package:flutter/material.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';

//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  User? _user; //dados de login
  //variável para armazenar credencial do usuário logado atualmente
  //essa variável armazena somente os dados de login (email, uid, phoneNumber, photoURI, etc)
  //por isso para recuperar os dados armazenados no bando de dados é utilizado a variável userData
  //para recuperar dados do db usa-se _user.uid
  Map<String, dynamic>? _userData; //dados do usuario

  void signUp(Map<String, dynamic> data, String password,
      VoidCallback? success(), VoidCallback? fail()) async {
    await this
        ._auth
        .createUserWithEmailAndPassword(
            email: data['email'], password: password)
        .then((value) async {
      await this
          ._db
          .collection('users')
          .doc(value.user!
              .uid) //usuário identificado pelo uid (o uid é gerado automaticamente pelo firebase e é único para cada usuário)
          .set(data); //armazenado usuário no banco de dados
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

  void signIn(String email, String password, VoidCallback? success(),
      VoidCallback? fail()) async {
    await this
        ._auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      this._user = _auth.currentUser;
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

  void editPasswordUser(String oldPassword, String newPassword,
      VoidCallback? success(), VoidCallback? fail()) {}

  void editUser(Map<String, dynamic> data, String password,
      VoidCallback? success(), VoidCallback? fail()) async {
    await _db
        .collection('users')
        .doc(_user!
            .uid) //buscando usuário pelo uid (_user sempre armazena o usuário logado atualmente)
        .update(data)
        .then((value) {})
        .catchError((e) {});
  }

  void logout(VoidCallback? success(), VoidCallback? fail()) async {
    await _auth.signOut().then((value) {
      this._user = null;
      this._userData = {};
      success();
    }).catchError((e) {
      print(e);
      fail();
    });
  }

  Future loadUserData() async {}

  Future<Map<String, dynamic>> getUserData() async {
    await this._db.collection('users').doc(this._user!.uid).get().then((value) {
      this._userData = value.data();
    }).catchError((e) {
      print(e);
    });
    return this._userData!;
  }

  bool isLoggedIn() {
    this._user = _auth.currentUser;
    return this._user != null;
  }
}
