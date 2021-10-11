// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';

//screens
import 'package:rota_segura_app/screens/admin/home.dart';
import 'package:rota_segura_app/screens/login.dart';
import 'package:rota_segura_app/screens/home.dart';

//models
import 'package:rota_segura_app/models/userRouteMap.dart';
import 'package:rota_segura_app/models/admin.dart';
import 'package:rota_segura_app/models/user.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModel<UserRouteMap>(
            model: UserRouteMap(),
            child: ScopedModel<AdminModel>(
                model: AdminModel(),
                child: ScopedModelDescendant<UserModel>(
                    builder: (context, child, model) {
                  return MaterialApp(
                      title: 'rota segura',
                      debugShowCheckedModeBanner: false,
                      home: model.isLoggedIn()
                          ? (model.isAdmin() ? AdminHome() : HomePage())
                          : LoginPage());
                }))));
  }
}
