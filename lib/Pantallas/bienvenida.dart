import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences_android/shared_preferences_android.dart';

class Bienvenida extends StatefulWidget {
  const Bienvenida({super.key, required this.title});

  final String title;

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
  SharedPreferences? prefs;
  void iniciaPreferencias() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
  }


  int _counter = 1;
  double _tamanoTexto = 24.0; // Tamaño inicial del texto

  TextEditingController _nombre =TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _sizeoftexto() {
    setState(() {
      _tamanoTexto += 5.0; // Aumenta el tamaño en 5 píxeles por clic
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.destructiveRed,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Pàgina dowos'),
            SizedBox(
              width: 300,
              child: TextField(
                controller:  _nombre,
                style:
                  TextStyle(
                    fontSize: 32,
                  ),
              ),
            ),
            MaterialButton(onPressed: (){},
              child: Text('ACEPTAR'),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Sumar al contador',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _sizeoftexto,
            tooltip: 'Aumentar tamaño del texto',
            child: const Icon(Icons.zoom_in),
          ),
        ],
      ),
    );
  }
}