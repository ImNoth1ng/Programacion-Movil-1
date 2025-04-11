import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key, required this.title});

  final String title;

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  double _cacheoperacion = 0;
  final String _cacheop = "";
  final double _alturabotones= 60;
  double _res = 0;
  int _divisoraux = 10;//nos ayuda a agregar decimales
  final bool _hayoperacion = false; //nos ayuda a saber si teemos algo en _cacheoperacion
  bool _punto = false;

  bool _suma = false;
  bool _resta = false;
  bool _multi = false;
  bool _div = false;

  bool _limpio = false;

  //FUNCIONES DE LOS BOTONES
  void _AddNum(int num){
    setState(() {
      if (!_punto){_res = _res*10+num;}else { _res = _res+(num/_divisoraux); _divisoraux*= 10; }
    });}
  void _Operacion(String op){
    setState(() {

     // _hayoperacion ? _doOp() : true;
      _resetOps();
      switch (op){
        case "+":setState(() {
          _cacheoperacion ==0 ? _cacheoperacion = _res : _cacheoperacion += _res;
          _res = 0;
          _suma=true;
        });
          break;
        case "-":
          setState(() {
            _cacheoperacion ==0 ? _cacheoperacion = _res : _cacheoperacion -= _res;
            _res = 0;
            _resta=true;
          });
          break;
        case "*":
          setState(() {
            _cacheoperacion ==0 ? _cacheoperacion = _res : _cacheoperacion *= _res;
            _res = 0;
            _multi=true;
          });
          break;
        case "/":
          setState(() {
            _cacheoperacion ==0 ? _cacheoperacion = _res : _cacheoperacion /= _res;
            _res = 0;
            _div=true;
          });
          break;
      }
    });
  }
  void _ObtenerResultado(){
    setState(() {
      _doOp();
      _res = _cacheoperacion;
      _cacheoperacion = 0;
      _resetOps();
    });
  }
  void _doOp(){
    if (_suma) {
      _cacheoperacion += _res;
    }
    if (_resta) {
      _cacheoperacion -= _res;
    }
    if (_div) {
      _cacheoperacion = _cacheoperacion / _res;
    }
    if (_multi) {
      _cacheoperacion *= _res;
    }
  }
  void _resetOps(){
    setState(() {
       _punto = false; _divisoraux = 10;
      _resetFlagsOP();
    });
  }
  void _resetFlagsOP(){  
    _suma = false; _resta = false; _multi = false; _div = false;  }
  void _Limpiar(){
    setState(() {
      if (_limpio){
        _ObtenerResultado();
        _res= 0;

      } else{
        _limpio = true;
        _res = 0;
        _resetOps();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      appBar: AppBar(
        backgroundColor: CupertinoColors.destructiveRed,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: <Widget>[
            Container(

              width: 355,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$_cacheoperacion',
                      style: TextStyle( // Usa _tamañoTexto para el tamaño
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),

                    ),
                    Text(
                      '$_res',
                      style: TextStyle( // Usa _tamañoTexto para el tamaño
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),

                    ),
                  ]
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [

                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(1);},
                  child: Text("1",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(2);},
                  child: Text("2",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(3);},
                  child: Text("3",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_Operacion("+");},
                  child: Text("+",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),



              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [

                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(4);},
                  child: Text("4",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(5);},
                  child: Text("5",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(6);},
                  child: Text("6",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_Operacion("-");},
                  child: Text("-",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),



              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [

                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(7);},
                  child: Text("7",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(8);},
                  child: Text("8",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(9);},
                  child: Text("9",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_Operacion("*");},
                  child: Text("*",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),



              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [

                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_Limpiar();},
                  child: Text("DEL",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_AddNum(0);},
                  child: Text("0",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){setState(() {
                    _punto = true;
                  });},
                  child: Text(".",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                MaterialButton(
                  height: _alturabotones,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_Operacion("/");},
                  child: Text("/",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),



              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [

                MaterialButton(
                  height: _alturabotones,
                  minWidth: 180,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: (){_ObtenerResultado();},
                  child: Text("=",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),




              ],
            ),
          ],
        ),
      ),
    );
  }
}