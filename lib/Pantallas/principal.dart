import 'package:epico1/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Principal extends StatefulWidget {
  const Principal({super.key, required this.title});

  final String title;

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _counter = 0;
  String _saludo = "Un Saludo";
  String? _name;

  final String? _user = LocalStorage.prefs.getString('user');

  // Función que obtiene el saludo desde Firestore
  Future<void> _getSaludo() async {
    try {
      final docRef = db.collection("users").doc(_user);
      final DocumentSnapshot doc = await docRef.get(); // Esperamos a que se resuelva el Future
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _counter = data['saludos']?.toInt() ?? 0;
          _actualizarSaludo(); // Actualizamos el texto del saludo
        });
      } else {
        print("El documento no existe");
      }
    } catch (e) {
      print("Error obteniendo el documento: $e");
    }
  }

  // Función para actualizar el texto del saludo
  void _actualizarSaludo() {
    if (_counter > 0) {
      _saludo = '$_counter saludos';
    } else if (_counter == 1) {
      _saludo = "Un Saludo";
    } else if (_counter == 0) {
      _saludo = "NO HAY SALUDOS";
    } else if (_counter < 0) {
      _saludo = "Hay una deuda de ${_counter * -1} saludos";
    }
  }

  // Incrementa el contador y actualiza el saludo
  void _incrementCounter() {
    setState(() {
      _counter++;
      //db.collection("saludos").doc("test").set(test); // Actualizamos Firestore
      db.collection("users").doc(_user).set({'saludos': _counter}, SetOptions(merge: true)); // Actualizamos Firestore
      _actualizarSaludo();
    });
  }

  // Decrementa el contador y actualiza el saludo
  void _decrementCounter() {
    setState(() {
      _counter--;
      //db.collection("saludos").doc("test").set(test); // Actualizamos Firestore
      db.collection("users").doc(_user).set({'saludos': _counter}, SetOptions(merge: true)); // Actualizamos Firestore
      _actualizarSaludo();
    });
  }

  @override
  void initState() {
    super.initState();

    // Cargamos el valor inicial desde Firestore
    _getSaludo();

    // Obtenemos el nombre del usuario desde LocalStorage
    final storedName = LocalStorage.prefs.getString('nombre');
    if (storedName != null && storedName.isNotEmpty) {
      _name = storedName;
    } else {
      _name = "Ti";
    }
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
              '$_saludo Para $_name',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Restar',
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Sumar',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}