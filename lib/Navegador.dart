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
  void _cambiaPantalla(int i){
    _p = i;
    setState(() {
      _p
    });
  }

  void _pantalla(int i){

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