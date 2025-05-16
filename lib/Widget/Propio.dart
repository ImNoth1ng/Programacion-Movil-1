import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BotonPropio extends StatefulWidget {
  BotonPropio({super.key, required this.altura, required this.ancho, required this.presionando,
    required this.herramientas, required this.color});

  List<double> altura;
  List<double> ancho;
  List<VoidCallback> presionando;
  List<Widget> herramientas;
  List<Color> color;

  @override
  State<BotonPropio> createState() => _BotonPropioState();
}

class _BotonPropioState extends State<BotonPropio> {

  List<Widget> _botones=[];

  @override
  void initState() {
    super.initState();
    _crearBotones();
  }

  void _crearBotones(){
    if(widget.ancho.length != widget.altura.length || widget.ancho.length != widget.presionando.length || widget.ancho.length != widget.herramientas.length){
      print("Incosistencia en los datos");
      throw Error();
    }else{
      for(int i=0; i<widget.ancho.length; i++){
        _botones.add(
          Center(
              child: SizedBox(
                width: widget.ancho[i],
                height: widget.altura[i],
                child: Padding(
                    padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                  child: ElevatedButton(
                    onPressed: widget.presionando[i],
                    child: widget.herramientas[i],
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(widget.color[i])),
                  ),
                ),
              ),
          )
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: _botones,
      ),
    );
  }
}
