import 'package:epico1/Pantallas/Calendar.dart';
import 'package:epico1/Pantallas/calc.dart';
import 'package:epico1/Pantallas/custom.dart';
import 'package:flutter/material.dart';
import 'package:epico1/Pantallas/principal.dart';
import 'package:epico1/Pantallas/segunda.dart';
import 'package:epico1/Pantallas/bienvenida.dart';
import 'package:epico1/Pantallas/Coords.dart';

class Navegador extends StatefulWidget {
  const Navegador({super.key});

  @override
  State<Navegador> createState() => _NavegadorState();
}

class _NavegadorState extends State<Navegador> {
  // Índice de la pantalla actual
  int _indiceActual = 0;

  // Lista de pantallas disponibles
  final List<Widget> _pantallas = [
    const Bienvenida(title: "Bienvenido"),
    const Principal(title: "Un Saludo xd"),
    const Calculadora(title: "Calculadora Epica"),
    const Segunda(title: "Segunda patalla"),
    const CoordsScreen(title: "Coordenadas"),
    const Calendario(title: "Calendario"),
    const Tarjetas(title: "TarjetasC")
  ];

  // Método para cambiar de pantalla
  void _cambiarPantalla(int indice) {
    setState(() {
      _indiceActual = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cuerpo de la aplicación que muestra la pantalla actual
      body: _pantallas[_indiceActual],
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _indiceActual,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Bienvenida',
          ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Coordenadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize),
            label: 'Personalizar',
          ),
        ],
        onTap: _cambiarPantalla,
      ),
    );
  }
}