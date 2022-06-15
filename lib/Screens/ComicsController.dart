import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:apimarvel/Models/ComicsNew.dart';
import 'package:apimarvel/Screens/Helper.dart';
import 'package:rxdart/subjects.dart';

class ComicsController extends BlocBase {
  //BLOC PERSONAGEM
  BehaviorSubject<List<ComicsNew>> blocComics = new BehaviorSubject();
  Sink<List<ComicsNew>> get inComics => blocComics.sink;
  Stream<List<ComicsNew>> get outComics => blocComics.stream;
  //FIM BLOC PERSONAGEM

  List<ComicsNew>? listaComics;

  getComics(int idPersonagem) {
    listaComics = [];
    inComics.add(listaComics!);

    String urlFinal = gerarUrl("characters/$idPersonagem/comics", adicional: "&limit=25");

    http.get(Uri.parse(urlFinal)).then((value) {
      var comicJson = jsonDecode(value.body)["data"]["results"];
      for (var c in comicJson) {
        ComicsNew comic = ComicsNew.fromJson(c);
        listaComics!.add(comic);
      }
      inComics.add(listaComics!);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

ComicsController comicsC = new ComicsController();
