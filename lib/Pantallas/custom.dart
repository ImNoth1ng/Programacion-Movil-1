import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widget/Personalizable.dart';

class Tarjetas extends StatefulWidget {
  const Tarjetas({super.key, required this.title});

  final String title;

  @override
  State<Tarjetas> createState() => _TarjetasState();
}

class _TarjetasState extends State<Tarjetas> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemYellow,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              'Tarjetas',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            TarjetasPerso(
                nombres: ["UNAM", "IPN", "TEC de Monterrey","UNAM", "IPN", "TEC de Monterrey"],
                descripciones: ["Universidad publica", "Universidad publica", "Universidad privada","Universidad publica", "Universidad publica", "Universidad privada"],
                rutas: ["assets/images/unam.jpg","assets/images/poli.jpg", "assets/images/tec.jpg","assets/images/unam.jpg","assets/images/poli.jpg", "assets/images/tec.jpg"],
            )
          ],
        ),
      ),
    );
  }
}