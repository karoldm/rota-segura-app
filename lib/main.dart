import 'package:flutter/material.dart';
import 'package:rota_segura_app/screens/profile_screen.dart';
import 'package:scoped_model/scoped_model.dart';

//my_app
import 'package:rota_segura_app/screens/login_screen.dart';
import 'package:rota_segura_app/models/user_model.dart';

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
        child:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return MaterialApp(
              title: 'rota segura',
              debugShowCheckedModeBanner: false,
              home: model.isLoggedIn() ? ProfilePage() : LoginPage());
        }));
  }
}
