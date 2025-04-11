import 'package:epico1/services/local_storage.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({super.key, required this.title});

  final String title;

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _counter = 0;
  String _Saludo = "Un Saludo";
  void _incrementCounter() {
    setState(() {

      _counter++;
      _Saludos();
    });
  }

  void  _Saludos(){
    if (_counter > 0){
      _Saludo = '${_counter+1} saludos';
    } else if (_counter == 0){
      _Saludo = "Un Saludo";
    } else if (_counter == -1){
      _Saludo = "NO HAY SALUDOS";
    } else if (_counter < -1){
      _Saludo = "Hay una deuda de ${(_counter+1)*-1} saludos";
    }
  }

  String? _name;

  @override
  void initState() {
    _Saludos();
    if (LocalStorage.prefs.getString('nombre') != null || LocalStorage.prefs.getString('nombre') != "" ){
      _name = LocalStorage.prefs.getString('nombre');
    } else { _name = "Usuari@";}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_Saludo Para: $_name',
              style: TextStyle( fontSize: 24,),
            ),
            /*Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),*/
            FloatingActionButton(onPressed: (){
              setState(() {
                _counter--;
                _Saludos();
              });


            },

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        hoverColor: Theme.of(context).colorScheme.onPrimary,

        tooltip: 'Suma xd',
        child: const Icon(Icons.add_circle_outline_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
