import 'package:flutter/material.dart';

class AdminHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff3dbeff),
          title: Text(
            "Rota Segura",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 25),
                        child: Text("Guia para o aplicativo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    Text(
                        "O aplicativo rota segura foi desenvolvido com o intuito de auxiliar agentes de segurança a chegar mais rápido até as pessoas que solicitam ajuda. Na página inicial do aplicativo é possível visualizar todas as chamadas ativas com os respectivos dados de quem está solicitando ajuda. Para poder chegar até o local você pode clicar em 'visualizar rota' e em seguida o caminho cadastrado pelo usuário será exibido em um mapa.",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/admin-1.png')),
                    Text(
                        "Na rota desenhada pelo usuário há vários marcadores. Para cada marcador o usuário pode adicionar uma descrição e uma imagem do local. Para visualizar essas informações basta clicar em cima do marcador.",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify),
                    Image(image: AssetImage('images/admin-2.png')),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/admin-3.png')),
                    SizedBox(height: 15),
                    Text(
                        "Para finalizar uma chamada basta pressionar 'finalizar chamada'.",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify),
                  ],
                ))));
  }
}
