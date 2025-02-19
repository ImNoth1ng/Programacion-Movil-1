import 'package:epico1/Pantallas/calc.dart';
import 'package:flutter/material.dart';
import 'package:epico1/Pantallas/principal.dart';
import 'package:epico1/Pantallas/segunda.dart';

class Navegador extends StatefulWidget{
  const Navegador({super.key});

  @override
  State<Navegador> createState() => _NavegadorState();

}

class _NavegadorState extends State<Navegador> {

  Widget? _cuerpo;

  int _p =0;
  void _cambiaPantalla(int i) {
    setState(() {
      _p = i;
      if (_p == 0){
        _cuerpo = Principal(title: "Epico Ouo");
      } else if (_p == 1) {
        _cuerpo = Segunda(title: "Pagina Dowos",);
      } else if (_p == 3 ){
        _cuerpo = Calculadora(title: "Calculadora");
      }
    });
  }





  @override
  void initState(){
    _cuerpo = const Principal(title: "Epico Ouo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _cuerpo,
    bottomNavigationBar: BottomNavigationBar(
    items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Principal',),
    BottomNavigationBarItem(
      icon: Icon(Icons.star),
      label: 'Segunda',

    ),
        ],
      currentIndex: _p,
      selectedItemColor: Colors.amber[800],
      onTap: _cambiaPantalla,)
    );
  }
}