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
  int _pantalla= 0;

  final _Pantallas = [
    const Principal(title: "Epico Ouo"),
    const Segunda(title: "Segunda patalla"),
    const Calculadora(title: "Calculadora Epica")
  ];

  void _cambiaPantalla(int i) {//recibe indice para saber el boton pulsado
    setState(() {
      if(i == 0){//ATRAS
        if(!(_pantalla == 0)){
          _pantalla--;
        }
      } else if (i == 1) {//ADELANTE
        if(!(_pantalla == _Pantallas.length-1)){
          _pantalla++;
        }
      }
      _cuerpo = _Pantallas[_pantalla];
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
    items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Icon(Icons.arrow_back_rounded),
    label: 'Atras',),
    BottomNavigationBarItem(
      icon: Icon(Icons.arrow_forward_rounded),
      label: 'Adelante',

    ),
        ],
      currentIndex: _p,
      selectedItemColor: Colors.amber[800],
      onTap: _cambiaPantalla,)
    );
  }
}