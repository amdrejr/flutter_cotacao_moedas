import 'package:coin_analytic/telas/tab_cotar_criptos.dart';
import 'package:coin_analytic/telas/tab_cotar_moedas.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List<Widget> _telas = [
    const CotarMoedas(),
    const CotarCriptos(),
  ];

  final List<BottomNavigationBarItem> itens = const [
    BottomNavigationBarItem(
        label: 'Moedas', icon: FaIcon(FontAwesomeIcons.moneyBill1Wave)),
    BottomNavigationBarItem(
        label: 'Criptos', icon: FaIcon(FontAwesomeIcons.bitcoin)),
  ];

  int _indiceAtual = 0;

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste'),
      ),
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        items: itens,
        onTap: onTabTapped,
      ),
    );
  }
}
