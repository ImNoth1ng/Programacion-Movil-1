import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TarjetasPerso extends StatefulWidget {
   TarjetasPerso({super.key, required this.nombres, required this.descripciones, required this.rutas});

  List<String> nombres;
  List<String> descripciones;
  List<String> rutas;



  @override
  State<TarjetasPerso> createState() => _TarjetasPersoState();
}


class _TarjetasPersoState extends State<TarjetasPerso> {

  List<Widget> _tarjetas=[];

  @override
  void initState() {
    super.initState();
    _llenarTarjetas();
  }

  void _llenarTarjetas(){
    if(widget.nombres.length!=widget.descripciones.length || widget.descripciones.length!=widget.rutas.length || widget.nombres.length!=widget.rutas.length){
      print("Incosistencia en los datos");
      throw Error();
    }else{
      for(int i=0; i<widget.nombres.length; i++){
        _tarjetas.add(
          Center(
              child: Card(
                color: Colors.indigoAccent,
                child: SizedBox(
                    width: 550,
                    height: 250,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Row(
                        children: [
                          Image.asset(
                            widget.rutas[i],
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.nombres[i], style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 15),
                              Text(widget.descripciones[i],style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, color: Colors.deepOrange)),
                            ],
                          )
                        ],
                      ),
                    )
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
        children: _tarjetas,
      ),
    );
  }
}
