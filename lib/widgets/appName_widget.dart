import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff004F77), Color(0xff3DBEFF)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        'Rota Segura',
        style: new TextStyle(
            fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      Image.asset(
        'images/markermap.png',
        height: 60,
        width: 60,
      )
    ]));
  }
}
