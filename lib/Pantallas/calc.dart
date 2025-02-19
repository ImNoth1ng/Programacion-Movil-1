import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key, required this.title});

  final String title;

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  int _counter = 1;
  double _res = 0;
  double _tamanoTexto = 24.0; // Tamaño inicial del texto

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
            const Text(""),
            Text(
              '$_counter',
              style: TextStyle( // Usa _tamañoTexto para el tamaño
                fontSize: _tamanoTexto,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            Row(
              children: [
                MaterialButton(

                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){},
                ),

              ],
            ),

            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _counter--;
                });
              },
              child: const Icon(Icons.remove),
            ),
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