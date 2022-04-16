import 'package:coin_analytic/app_collors.dart';
import 'package:coin_analytic/telas/tela_principal.dart';
import 'package:flutter/material.dart';

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
    theme: ThemeData(
        hintColor: Colors.amber[600],
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppCollor.primary)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppCollor.secondary)),
          hintStyle: TextStyle(color: AppCollor.primary),
          labelStyle: TextStyle(color: AppCollor.secondary),
        )),
    home: TelaPrincipal(),
  ));
}
