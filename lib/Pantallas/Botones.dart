import 'package:epico1/Widget/Propio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Botones extends StatefulWidget {
  const Botones({super.key, required this.title});

  final String title;
  @override
  State<Botones> createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemPurple,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              'Botones',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            BotonPropio(
                altura: [100,150,130],
                ancho: [200,240,300],
                presionando: [
                      () => print('Botón 1 presionado'),
                      () => null,
                      () => print('Botón 3 presionado'),],
                herramientas: [Text(("Boton1")), Text("Boton2"), Text("Boton3")],
                color: [Colors.pinkAccent, Colors.orangeAccent, Colors.green])
          ],
        ),
      ),
    );
  }
}
