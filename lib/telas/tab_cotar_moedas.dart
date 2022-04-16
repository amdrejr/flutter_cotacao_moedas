import 'package:coin_analytic/app_collors.dart';
import 'package:coin_analytic/styles/styles_decorations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

const request = "https://api.hgbrasil.com/finance?format=json&key=e1fe1b46";

class CotarMoedas extends StatefulWidget {
  const CotarMoedas({Key? key}) : super(key: key);

  @override
  State<CotarMoedas> createState() => _CotarAppState();
}

class _CotarAppState extends State<CotarMoedas> {
  double? dolar;
  double? euro;
  double? real;

  final TextEditingController dolarController = TextEditingController();
  final TextEditingController euroController = TextEditingController();
  final TextEditingController realController = TextEditingController();

  void _clearAll() {
    euroController.text = '';
    realController.text = '';
    dolarController.text = '';
  }

  void _realChanged(String text) {
    double real;

    if (text.isNotEmpty) {
      real = double.parse(text);

      dolarController.text = (real / dolar!).toStringAsFixed(2);
      euroController.text = (real / euro!).toStringAsFixed(2);
    } else {
      _clearAll();
    }
  }

  void _euroChanged(String text) {
    double euro;

    if (text.isNotEmpty) {
      euro = double.parse(text);

      realController.text = (euro * this.euro!).toStringAsFixed(2);
      dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
    } else {
      _clearAll();
    }
  }

  void _dolarChanged(String text) {
    double dolar;

    if (text.isNotEmpty) {
      dolar = double.parse(text);

      realController.text = (dolar * this.dolar!).toStringAsFixed(2);
      euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
    } else {
      _clearAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map?>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                  child: CircularProgressIndicator(color: AppCollor.primary));
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao carregar os dados D:',
                    style: TextStyle(color: Colors.yellow),
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(24),
                      decoration: containerDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          buildTextField(
                            label: 'Real',
                            prefix: 'R\$ ',
                            controller: realController,
                            func: _realChanged,
                          ),
                          const Divider(color: Colors.transparent),
                          buildTextField(
                            label: 'Dolar',
                            prefix: 'US\$ ',
                            controller: dolarController,
                            func: _dolarChanged,
                          ),
                          const Divider(color: Colors.transparent),
                          buildTextField(
                            label: 'Euro',
                            prefix: '¢ ',
                            controller: euroController,
                            func: _euroChanged,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}
