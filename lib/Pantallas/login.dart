import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epico1/Pantallas/principal.dart';
import 'package:flutter/material.dart';
import 'package:epico1/services/local_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../Navegador.dart'; // for the utf8.encode method

FirebaseFirestore db = FirebaseFirestore.instance;



  class LoginPage extends StatefulWidget {
    const LoginPage({super.key});



  @override
  State<LoginPage> createState() => _LoginState();
  }

  class _LoginState extends State<LoginPage>{
    String _userName = '';
    String _password = '';
    String _hashedPassword = '';
    String _StoredPassword = '';
    var _passinbytes;

    TextEditingController _userNameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
    bool _compararPass(String pass) {
      _passinbytes = utf8.encode(pass);
      _StoredPassword = sha256.convert(_passinbytes).toString();
      if (_StoredPassword == _hashedPassword) {
        print("Las contraseñas coinciden");
        return true;
      }
      print("Las contraseñas no coinciden");
      return false;
    }

    Future<void> _getUserPass() async {
      try {
        final docRef = db.collection("users").doc(_userName);
        final DocumentSnapshot doc = await docRef.get(); // Esperamos a que se resuelva el Future
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            _hashedPassword = data['password'];
            print("Contraseña obtenida: $_hashedPassword");
            if (_compararPass(_password)) {
              LocalStorage.prefs.setString('user', _userName);
              // Navegar a la pantalla principal
              Navigator.pushReplacement(
              context,
                MaterialPageRoute(builder: (context) => const Navegador())
              );
            }
          });
        } else {
          print("El documento no existe");


        }
      } catch (e) {
        print("Error obteniendo el documento: $e");
      }
    }




    void _registrarse(String user, String password) async {
      try {
        // Hashear la contraseña usando SHA-256
        final bytes = utf8.encode(password); // Convierte la contraseña a bytes
        final hashedPassword = sha256.convert(bytes).toString(); // Genera el hash

        // Crear el documento en Firestore con los datos iniciales
        await db.collection("users").doc(user).set({
          'password': hashedPassword, // Contraseña hasheada
          'name': "", // Nombre vacío por defecto
          'saludos': 0, // Contador de saludos inicial en 0
        });

        print("Usuario registrado correctamente");
        setState(() {
          _errorMessage = "Usuario registrado correctamente";
        });
      } catch (e) {
        print("Error al registrar el usuario: $e");
      }
    }

    void _login() {
      print("login buitton");
      _userName = _userNameController.text;
      _password = _passwordController.text;
      _getUserPass();



    }

    String _errorMessage = '';

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  //logo
                  const Icon(
                    Icons.door_back_door,
                    size: 100,
                  ),
                  const SizedBox(height: 50),

                  Text(
                    'Bienvenido a la app :D',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _errorMessage,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 50),

                  Padding(padding: const EdgeInsets.symmetric(horizontal:  25.0),
                    child: TextField(
                      controller: _userNameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Nombre de usuario',
                          fillColor: Colors.grey[200],
                          filled: true,
                        )
                    ),),
                  const SizedBox(height: 10),

                  Padding(padding: const EdgeInsets.symmetric(horizontal:  25.0),
                    child: TextField(
                      controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Contraseña',
                          fillColor: Colors.grey[200],
                          filled: true,
                        )
                    ),),

                  const SizedBox(height: 20,),

                  GestureDetector(
                    onTap: (){_login();},
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,

                            ),

                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 5),

                  GestureDetector(
                    onTap: () {
                      _registrarse(_userNameController.text, _passwordController.text);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 5),




                ]
            ),
          )
      );
    }

  }