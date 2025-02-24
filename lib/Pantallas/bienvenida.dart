import 'package:epico1/services/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bienvenida extends StatefulWidget {
  const Bienvenida({super.key, required this.title});

  final String title;

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}




class _BienvenidaState extends State<Bienvenida> {


  int _counter = 1;
  double _tamanoTexto = 24.0; // Tamaño inicial del texto

  TextEditingController _Putnombre =TextEditingController();

  String? _getname() {
    if(LocalStorage.prefs.getString('nombre') != null){
      return LocalStorage.prefs.getString('nombre');
    }
    else {
      return '';
    }
  }

  String? _name;

  @override
  void initState() {
    _name = _getname();
    super.initState();
  }


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
          spacing: 30,
          children: <Widget>[
            SizedBox(
              height: 150
              ,
              child: Text('Bienvenido ${_name}',
                style: TextStyle(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,

              ),
            ),

            Text('Ingresa tu nombre: ',
              style: TextStyle(
                  fontSize: 18,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller:  _Putnombre,
                style:
                  TextStyle(
                    fontSize: 32,
                  ),
              ),
            ),
            MaterialButton(onPressed: (){
              setState(() {
                _name = (_Putnombre.text == "") ? 'Usuario' : _Putnombre.text;
                _Putnombre.text = "";
                LocalStorage.prefs.setString('nombre', _name!);
              });
            },
              child: Text('ACEPTAR'),
            )
          ],
        ),
      ),
      /*floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _sizeoftexto,
            tooltip: 'Aumentar tamaño del texto',
            child: const Icon(Icons.zoom_in),
          ),
        ],
      ),*/
    );
  }
}