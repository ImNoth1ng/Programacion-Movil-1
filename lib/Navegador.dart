import 'package:epico1/Pantallas/calc.dart';
import 'package:flutter/material.dart';
import 'package:epico1/Pantallas/principal.dart';
import 'package:epico1/Pantallas/segunda.dart';
import 'package:epico1/Pantallas/bienvenida.dart';

class Navegador extends StatefulWidget{
  const Navegador({super.key});

  @override
  State<Navegador> createState() => _NavegadorState();

}

class _NavegadorState extends State<Navegador> {

  Widget? _cuerpo;

  int _p =0;
  int _pantalla= 0;

  final _Pantallas = [
    const Bienvenida(title: "WellcUM"),
    const Principal(title: "Un Saludo xd"),
    const Calculadora(title: "Calculadora Epica"),
    const Segunda(title: "Segunda patalla")

  ];

  void _cambiaPantalla(int i) {//recibe indice para saber el boton pulsado
    setState(() {
      _cuerpo = _Pantallas[i];
    });
  }





  @override
  void initState(){
    _cuerpo = _Pantallas[_pantalla];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _cuerpo,
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Bienvenida',),
        BottomNavigationBarItem(

        icon: Icon(Icons.handshake),
        label: 'Saludo',

    ),
        BottomNavigationBarItem(
        icon: Icon(Icons.calculate),
        label: 'Calculadora',

      ),
        BottomNavigationBarItem(
          icon: Icon(Icons.numbers_rounded),
          label: 'Contador',

        ),
        ],
      currentIndex: _p,
      selectedItemColor: Colors.amber[800],
      onTap: _cambiaPantalla,)
    );
  }
}