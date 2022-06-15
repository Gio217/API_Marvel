import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:apimarvel/Models/Characters.dart';
import 'package:apimarvel/Screens/Helper.dart';
import 'package:rxdart/rxdart.dart';

class HomeController extends BlocBase {
  //BLOC PERSONAGEM
  BehaviorSubject<List<Characters>> blocPersoagem = new BehaviorSubject();
  Sink<List<Characters>> get inPerson => blocPersoagem.sink;
  Stream<List<Characters>> get outPerson => blocPersoagem.stream;
  //FIM BLOC PERSONAGEM

  List<Characters>? listaPersonagem;
  Characters? personagem;

  HomeController() {
    escolhePersonagem([
      1009351,
      1009220,
      1009610
    ]);
  }

  escolhePersonagem(List<int> ids) {
    listaPersonagem = [];

    for (var id in ids) {
      getPersonagemPorId(id);
    }
  }

  getPersonagemPorId(int id) {
    String urlFinal = gerarUrl("characters/$id");
    print(urlFinal);
    http.get(Uri.parse(urlFinal)).then((v) {
      var personagems = jsonDecode(v.body)["data"]["results"];
      for (var personagemTemp in personagems) {
        personagem = Characters.fromJson(personagemTemp);
        listaPersonagem!.add(personagem!);

        inPerson.add(listaPersonagem!);
      }
    });
  }

  atualizaQuadros(Characters perso) {
    for (var a in listaPersonagem!) {
      a.clicked = false;
    }
    perso.clicked = true;
    inPerson.add(listaPersonagem!);
  }

  @override
  void dispose() {
    blocPersoagem.close();
  }
}

HomeController homeC = new HomeController();
