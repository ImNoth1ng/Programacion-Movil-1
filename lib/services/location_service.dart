import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

/// Servicio para manejar la funcionalidad de ubicación
/// Proporciona métodos para verificar permisos, obtener la ubicación actual
/// y mostrar diálogos de configuración
class LocationService {
  /// Verifica si los servicios de ubicación están habilitados y solicita permisos si es necesario
  /// Retorna true si los servicios están habilitados y se tienen los permisos necesarios
  static Future<bool> checkAndRequestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Verificar permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Obtiene la ubicación actual del dispositivo
  /// Retorna la posición si se pudo obtener, null en caso contrario
  static Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await checkAndRequestLocationPermission();
      if (!hasPermission) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }

  /// Muestra un diálogo cuando los servicios de ubicación están desactivados
  /// Permite al usuario cancelar o ir a la configuración de ubicación
  static Future<void> showLocationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Servicios de ubicación desactivados'),
          content: const Text(
            'Los servicios de ubicación están desactivados. '
            'Por favor, actívalos para usar esta función.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Abrir Configuración'),
              onPressed: () {
                Geolocator.openLocationSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
} 