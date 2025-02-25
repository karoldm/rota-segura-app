// ignore_for_file: import_of_legacy_library_into_null_safe

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rota_segura/models/admin.dart';
import 'package:rota_segura/models/user.dart';
//models
import 'package:rota_segura/models/userRouteMap.dart';
//screens
import 'package:rota_segura/screens/admin/home.dart';
import 'package:rota_segura/screens/home.dart';
import 'package:rota_segura/screens/login.dart';
//libraries
import 'package:scoped_model/scoped_model.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
                home:
                    model.isLoggedIn()
                        ? (model.isAdmin() ? AdminHome() : HomePage())
                        : LoginPage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
