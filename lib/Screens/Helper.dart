import 'dart:convert';

import 'package:crypto/crypto.dart';

class Helper {
  static String publicApiKey = "c37ccb544634155520567b44484d3a95";
  static String privateApiKey = "b19841b27a99ab40a356bb12415626b4c06f5a56";
}

var url = "http://gateway.marvel.com/v1/public/";
var timeStamp = DateTime.now();
var hash;

String gerarUrl(String assunto, {String adicional = ""}) {
  gerarHash();
  String urlFinal = "$url$assunto?apikey=${Helper.publicApiKey}&hash=$hash&ts=${timeStamp.toIso8601String()}$adicional";
  print(urlFinal);
  return urlFinal;
}

gerarHash() {
  hash = generateMd5(timeStamp.toIso8601String() + Helper.privateApiKey + Helper.publicApiKey);
  print(hash);
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
