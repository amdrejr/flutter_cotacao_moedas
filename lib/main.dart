import 'package:flutter/material.dart';

import 'cotar_moedas.dart';

// Request de Clima Tempo
//final Uri request = Uri.http(
//    "api.hgbrasil.com", "/weather", {"format": "json-cors", "key": "e1fe1b46"});

// Request Cotação Moedas
//Link request: https://api.hgbrasil.com/finance/quotations?key=e1fe1b46

final Uri requestUri = Uri.http(
  "api.hgbrasil.com",
  "/finance/quotations",
  {
    "key": "e1fe1b46",
  },
);

void main() async {
  //print(await getData());
  runApp(MaterialApp(
    home: const CotarApp(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}
