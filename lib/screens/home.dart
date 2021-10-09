// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';

//models
import 'package:rota_segura_app/models/user.dart';
import 'package:rota_segura_app/models/userRouteMap.dart';

//libraries
import 'package:scoped_model/scoped_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//screens
import 'package:rota_segura_app/screens/login.dart';
import 'package:rota_segura_app/screens/profile.dart';
import 'package:rota_segura_app/screens/registerRoute.dart';
import 'package:rota_segura_app/screens/infoMarker.dart';

//widgets
import 'package:rota_segura_app/widgets/button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> dataUser = {};
  final LatLng _initialCamera = const LatLng(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, userModel) {
      return ScopedModelDescendant<UserRouteMap>(
          builder: (context, child, mapModel) {
        return FutureBuilder(
            future: userModel.getUserData(),
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                dataUser = snapshot.data!;
                return Scaffold(
                    backgroundColor: Colors.white,
                    drawer: Drawer(
                        child: ListView(children: <Widget>[
                      DrawerHeader(
                        child: Text(
                          'Bem Vindo(a) ' + dataUser['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff00AAFF),
                            image: DecorationImage(
                                image: AssetImage("images/mapMarker.png"),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter)),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.black),
                        title: Text('configurações'),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                //mandando usuário para a página de perfil
                                builder: (context) => EditPage())),
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.map,
                            color: Colors.black,
                          ),
                          title: Text('atualizar rota'),
                          onTap: () {
                            mapModel.clearMap();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    //mandando usuário para a página de cadastro de rota
                                    builder: (context) => RegisterRoutePage()));
                          }),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.black),
                        title: Text('sair'),
                        onTap: () => userModel.logout(() {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  //mandando usuário para a página de perfil
                                  builder: (context) => LoginPage()));
                        }, () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Erro ao sair!')));
                        }),
                      )
                    ])),
                    appBar: AppBar(
                      centerTitle: true,
                      leading: Builder(
                          builder: (conext) => IconButton(
                              onPressed: () => Scaffold.of(conext).openDrawer(),
                              icon: Icon(
                                Icons.menu,
                                size: 30,
                              ))),
                      actions: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.help,
                            color: Color(0xff005783),
                            size: 40,
                          ),
                        ),
                      ],
                      backgroundColor: Color(0xff3dbeff),
                      title: Text(
                        "Rota Segura",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    body: Container(
                        child: Stack(children: <Widget>[
                      FutureBuilder(future: mapModel.getPolyline(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                //mandando usuário para a página de perfil
                                builder: (context) => InfoMarker()));
                      }), builder:
                          (context, AsyncSnapshot<Set<Polyline>> snapshot) {
                        if (snapshot.hasData) {
                          return (GoogleMap(
                            onMapCreated: mapModel.onMapCreated,
                            polylines: mapModel.polyline,
                            markers: mapModel.markers,
                            initialCameraPosition: CameraPosition(
                              target: _initialCamera,
                            ),
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                            myLocationButtonEnabled: true,
                          ));
                        } else {
                          return (Center(child: CircularProgressIndicator()));
                        }
                      }),
                    ])));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
      });
    });
  }
}
