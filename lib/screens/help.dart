import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
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
                        "O aplicativo rota segura foi desenvolvido com o intuito de auxiliar agentes de segurança a chegar mais rápido até as pessoas que solicitam ajuda. Ao clicar na opção de “compartilhar rota” no menu lateral todos os seus dados cadastrados e também a rota cadastrada com suas respectivas informações adicionais (descrição e imagem) serão compartilhadas com os agentes de segurança.",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/route-1.png')),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/route-2.png')),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/route-3.png')),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/route-4.png')),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/route-5.png')),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/route-6.png')),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/route-7.png')),
                    SizedBox(height: 15),
                    Text(
                        "Para acionar a polícia a partir do aplicativo é necessário ter uma rota cadastrada. Para cadastrar ou atualizar a rota atual basta ir à opção “atualizar rota” no menu lateral. Um mapa será aberto com as opções de confirmar a atualização ou cancelar a operação. Ao clicar no mapa um marcador será criado naquele local, ao clicar em outro local outro marcador é criado e eles se ligam formando uma linha, criando assim um desenho para representar a rota. É importante ao criar uma rota procurar ser o mais preciso possível e sempre começar a desenhar a rota no local onde está sua residência . Além disso, procure sempre terminar a rota em algum lugar de fácil localização para a polícia começar a percorrer o caminho (lugares conhecidos ou até mesmo a delegacia mais próxima da sua residência).",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify),
                    Text(
                        "Como dito anteriormente, quando se está desenhando uma rota, toda vez que se clica no mapa um marcador é criado. Esses marcadores são importantes pois servem como pontos de referência. Na tela inicial, ao clicar em um desses marcadores (indicados por um círculo azul) uma nova tela se abrirá onde você pode inserir informações adicionais a fim de facilitar a localização da sua residência e o caminho percorrido até ela. Para cada marcador é possível adicionar uma descrição e uma imagem do local.	Como cada marcador pode exibir mais detalhes do caminho , ao criar uma rota, clicar e criar marcadores em locais estratégicos, com pontos de referências relevantes e de fácil identificação, isso garantirá que a ajuda chegue o mais rápido possível.",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/marker-1.png')),
                    SizedBox(height: 15),
                    Image(image: AssetImage('images/marker-2.png')),
                    SizedBox(height: 15),
                  ],
                ))));
  }
}
