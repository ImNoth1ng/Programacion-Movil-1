import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

/// Pantalla alternativa para mostrar la ubicación
/// Similar a CoordsScreen pero con un diseño diferente
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  /// Almacena la posición actual del dispositivo
  Position? _currentPosition;
  /// Mensaje que se muestra al usuario
  String _locationMessage = '';

  @override
  void initState() {
    super.initState();
    // Intentar obtener la ubicación al iniciar la pantalla
    _getCurrentLocation();
  }

  /// Método para obtener la ubicación actual
  /// Maneja permisos y errores
  Future<void> _getCurrentLocation() async {
    // Verificar permisos de ubicación
    bool hasPermission = await LocationService.checkAndRequestLocationPermission();
    if (!hasPermission) {
      // Si no hay permisos y el widget está montado, mostrar diálogo
      if (mounted) {
        await LocationService.showLocationDialog(context);
      }
      return;
    }

    try {
      // Intentar obtener la ubicación actual
      Position? position = await LocationService.getCurrentLocation();
      if (position != null) {
        // Si se obtuvo la ubicación, actualizar el estado
        setState(() {
          _currentPosition = position;
          _locationMessage = 'Latitud: ${position.latitude}\nLongitud: ${position.longitude}';
        });
      } else {
        // Si no se pudo obtener la ubicación, mostrar mensaje
        setState(() {
          _locationMessage = 'No se pudo obtener la ubicación';
        });
      }
    } catch (e) {
      // Si ocurre un error, mostrar el mensaje de error
      setState(() {
        _locationMessage = 'Error al obtener la ubicación: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con título
      appBar: AppBar(
        title: const Text('Ubicación'),
      ),
      // Cuerpo de la pantalla
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto que muestra la ubicación o mensajes
            Text(_locationMessage),
            const SizedBox(height: 20),
            // Botón para actualizar la ubicación
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Actualizar Ubicación'),
            ),
          ],
        ),
      ),
    );
  }
} 