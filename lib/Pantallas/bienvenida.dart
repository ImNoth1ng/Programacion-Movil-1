import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epico1/services/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bienvenida extends StatefulWidget {
  const Bienvenida({super.key, required this.title});

  final String title;

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}


FirebaseFirestore db = FirebaseFirestore.instance;


class _BienvenidaState extends State<Bienvenida> {

  final String? _user = LocalStorage.prefs.getString('user');

  final TextEditingController _Putnombre =TextEditingController();

  String? _getname() {
    if(LocalStorage.prefs.getString('nombre') != null){
      return LocalStorage.prefs.getString('nombre');
    }
    else {
      _getdbname();
    }
  }

  void _updateName(String newName) {
    LocalStorage.prefs.setString('nombre', newName);
    db.collection("users").doc(_user).set({'name': newName}, SetOptions(merge: true)); // Actualizamos Firestore
  }

  Future<void> _getdbname() async {
    try {
      // Obtén el usuario almacenado en LocalStorage


      // Verifica que _user no sea nulo
      if (_user == null || _user.isEmpty) {
        print("No se encontró un usuario en LocalStorage");
        return;
      }

      // Referencia al documento en la colección "users"
      final docRef = db.collection("users").doc(_user);

      // Obtén el documento
      final DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        // Convierte los datos del documento a un Map
        final data = doc.data() as Map<String, dynamic>;

        // Actualiza el estado con el campo "name"
        setState(() {
          _name = data['name'] ?? 'Nombre no disponible'; // Asigna el valor de "name" o un valor por defecto
          _updateName(_name!); // Actualiza el nombre en LocalStorage
        });
      } else {
        print("El documento no existe");
      }
    } catch (e) {
      print("Error obteniendo el documento: $e");
    }
  }

  String? _name;

  @override
  void initState() {
    _getdbname();
    super.initState();
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
              child: Text('Bienvenido $_name',
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
                _updateName(_name!);
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