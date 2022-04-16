import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String cripto = 'BTC';

final String request = "https://www.mercadobitcoin.net/api/$cripto/ticker";

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Cotar Criptos'),
        ElevatedButton(
            onPressed: () async {
              var texto = await getData();

              print(texto['ticker']['last']);
            },
            child: const Text('Testar'))
      ],
    );
  }
}
