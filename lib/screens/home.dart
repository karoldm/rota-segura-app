// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//models
import 'package:rota_segura/models/user.dart';
import 'package:rota_segura/models/userRouteMap.dart';
//screens
import 'package:rota_segura/screens/help.dart';
import 'package:rota_segura/screens/infoMarker.dart';
import 'package:rota_segura/screens/login.dart';
import 'package:rota_segura/screens/profile.dart';
import 'package:rota_segura/screens/registerRoute.dart';
//widgets
import 'package:rota_segura/widgets/button.dart';
import 'package:rota_segura/widgets/inputPassword.dart';
//libraries
import 'package:scoped_model/scoped_model.dart';

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
            mapModel.clearMap();
            return FutureBuilder(
              future: userModel.getUserData(),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  dataUser = snapshot.data!;
                  return Scaffold(
                    backgroundColor: Colors.white,
                    drawer: Drawer(
                      child: ListView(
                        children: <Widget>[
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: Color(0xff00AAFF),
                              image: DecorationImage(
                                image: AssetImage("images/mapBackground.png"),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            child: Text(
                              'Bem Vindo ${dataUser['name']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.settings, color: Colors.black),
                            title: Text('configurações'),
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    //mandando usuário para a página de perfil
                                    builder: (context) => EditPage(),
                                  ),
                                ),
                          ),
                          ListTile(
                            leading: Icon(Icons.delete, color: Colors.black),
                            title: Text('deletar minha conta'),
                            onTap: () {
                              TextEditingController _password =
                                  TextEditingController();
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      actionsPadding: const EdgeInsets.all(
                                        15.0,
                                      ),
                                      titlePadding: const EdgeInsets.all(15.0),
                                      contentPadding: const EdgeInsets.all(
                                        15.0,
                                      ),
                                      title: Text(
                                        'Deletar Conta',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(
                                        'Digite sua senha para continuar',
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 20.0,
                                          ),
                                          child: InputPassword(
                                            placeholder: 'senha',
                                            controller: _password,
                                          ),
                                        ),
                                        Button(
                                          title: 'Confirmar',
                                          function: () {
                                            userModel.delet(
                                              _password.text,
                                              () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            LoginPage(),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      'Conta deletada com sucesso!',
                                                    ),
                                                  ),
                                                );
                                              },
                                              () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                        title: Text('Erro'),
                                                        content: Text(
                                                          'Algo deu errado ao deletar sua conta! Tente novamente...',
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      ),
                                                );
                                              },
                                            );
                                          },
                                          colors: [0xffDB0000, 0xffDB0000],
                                        ),
                                        Button(
                                          title: 'cancelar',
                                          function: () {
                                            Navigator.pop(context);
                                          },
                                          colors: [0xffC5C5C5, 0xffC5C5C5],
                                        ),
                                      ],
                                    ),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.map, color: Colors.black),
                            title: Text('atualizar rota'),
                            onTap: () {
                              mapModel.clearMap();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //mandando usuário para a página de cadastro de rota
                                  builder: (context) => RegisterRoutePage(),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.logout, color: Colors.black),
                            title: Text('sair'),
                            onTap:
                                () => userModel.logout(
                                  () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        //mandando usuário para a página de perfil
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Erro ao sair!'),
                                      ),
                                    );
                                  },
                                ),
                          ),
                          ListTile(
                            leading: Icon(Icons.share, color: Colors.white),
                            title: Text(
                              'compartilhar rota',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              userModel.shareRoute(
                                () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: Text("Compartilhando rota"),
                                          content: Text(
                                            "Seus dados assim como as informações da rota até sua residência foram compartilhados! Em breve a ajuda chegará até você.",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Ok"),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Algo deu errado ao compartilhar a rota! tente novamente..',
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            tileColor: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    appBar: AppBar(
                      centerTitle: true,
                      leading: Builder(
                        builder:
                            (conext) => IconButton(
                              onPressed: () => Scaffold.of(conext).openDrawer(),
                              icon: Icon(Icons.menu, size: 30),
                            ),
                      ),
                      actions: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: IconButton(
                            icon: Icon(Icons.help, size: 40.0),
                            color: Color(0xff005783),
                            onPressed:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    //mandando usuário para a página de perfil
                                    builder: (context) => HelpPage(),
                                  ),
                                ),
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
                      child: Stack(
                        children: <Widget>[
                          FutureBuilder(
                            future: mapModel.getPolyline(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //mandando usuário para a página de perfil
                                  builder: (context) => InfoMarker(),
                                ),
                              );
                            }),
                            builder: (
                              context,
                              AsyncSnapshot<Set<Polyline>> snapshot,
                            ) {
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
                                return (Center(
                                  child: CircularProgressIndicator(),
                                ));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        );
      },
    );
  }
}
