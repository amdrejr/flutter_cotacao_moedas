import 'package:coin_analytic/styles/styles_decorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../app_collors.dart';

var bitcoin;
var etherium;
var chiliz;

Future<Map> getData(String cripto) async {
  http.Response response = await http
      .get(Uri.parse("https://www.mercadobitcoin.net/api/$cripto/ticker"));
  bitcoin = json.decode(response.body);
  etherium = getData('ETH');
  chiliz = getData('CHZ');
  return json.decode(response.body);
}

class CotarCriptos extends StatefulWidget {
  const CotarCriptos({Key? key}) : super(key: key);

  @override
  State<CotarCriptos> createState() => _CotarCriptosState();
}

class _CotarCriptosState extends State<CotarCriptos> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<dynamic, dynamic>>(
        future: getData('BTC'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  color: AppCollor.primary,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao carregas os dados D:',
                    style: TextStyle(color: AppCollor.secondary),
                  ),
                );
              } else {
                print(bitcoin['ticker']['last']);

                return Column(
                  children: [
                    Text(bitcoin['ticker']['last']),
                    Text(chiliz['ticker']),
                  ],
                );
              }
          }
        });
  }
}

class BuildDropDown extends StatefulWidget {
  const BuildDropDown({Key? key}) : super(key: key);

  @override
  State<BuildDropDown> createState() => _BuildDropDownState();
}

class _BuildDropDownState extends State<BuildDropDown> {
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  List<String> itens = ['BTC', 'ETH', 'chz'];
  String? valor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  constraints: BoxConstraints(maxHeight: 60)),
              value: valor,
              items: itens.map(buildMenuItem).toList(),
              onChanged: (value) => setState(() {
                    valor = value;
                  })
              //setState(() => valor = value),
              ),
        ),
        const SizedBox(width: 15),
        const Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('Valor'),
            ),
          ),
        ),
      ],
    );
  }
}

Widget teste(String cripto, vari) => FutureBuilder<Map<dynamic, dynamic>>(
    future: getData(cripto),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return const Center(
            child: CircularProgressIndicator(
              color: AppCollor.primary,
            ),
          );
        default:
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregas os dados D:',
                style: TextStyle(color: AppCollor.secondary),
              ),
            );
          } else {
            vari = snapshot.data!['ticker']['sell'];
            return Container();
          }
      }
    });
