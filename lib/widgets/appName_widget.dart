import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
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
