import 'package:epico1/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  await LocalStorage.configurePrefs();
  runApp(const MyApp());
}


