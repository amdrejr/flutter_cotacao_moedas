import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

const request = "https://api.hgbrasil.com/finance?format=json&key=e1fe1b46";

class CotarApp extends StatefulWidget {
  const CotarApp({Key? key}) : super(key: key);

  @override
  State<CotarApp> createState() => _CotarAppState();
}

class _CotarAppState extends State<CotarApp> {
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Conversor de Moedas'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map?>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                  child: CircularProgressIndicator(color: Colors.red));
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao carregar dados D:',
                    style: TextStyle(color: Colors.yellow),
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      const Divider(),
                      buildTextField(
                        label: 'Real',
                        prefix: 'R\$ ',
                        controller: realController,
                        func: _realChanged,
                      ),
                      const Divider(),
                      buildTextField(
                        label: 'Dolar',
                        prefix: 'US\$ ',
                        controller: dolarController,
                        func: _dolarChanged,
                      ),
                      const Divider(),
                      buildTextField(
                        label: 'Euro',
                        prefix: '¢ ',
                        controller: euroController,
                        func: _euroChanged,
                      ),
                    ],
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

Widget buildTextField({
  required String label,
  required String prefix,
  required TextEditingController controller,
  Function(String)? func,
}) {
  return TextField(
    controller: controller,
    onChanged: (String value) {
      func!(value);
    },
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: label,
      prefixText: prefix,
    ),
    style: const TextStyle(fontSize: 25, color: Colors.yellow),
  );
}
