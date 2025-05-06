import 'package:epico1/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Función principal de la aplicación
/// Inicializa los servicios necesarios y lanza la aplicación
void main() async {
  // Inicializar los bindings de Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurar el almacenamiento local
  await LocalStorage.configurePrefs();
  
  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Lanzar la aplicación
  runApp(const MyApp());
}


