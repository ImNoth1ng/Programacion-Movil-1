import 'package:epico1/Navegador.dart';
import 'package:flutter/material.dart';

import 'Pantallas/login.dart';





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EPIC APP :O',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,

      ),
      home: const LoginPage(),
    );
  }
}


