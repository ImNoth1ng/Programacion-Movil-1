import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

/// Pantalla que muestra y permite obtener las coordenadas actuales del dispositivo
/// Utiliza el LocationService para manejar permisos y obtener la ubicación
class CoordsScreen extends StatefulWidget {
  const CoordsScreen({super.key, required this.title});

  final String title;

  @override
  State<CoordsScreen> createState() => _CoordsScreenState();
}

class _CoordsScreenState extends State<CoordsScreen> {
  /// Texto que muestra las coordenadas o mensajes de estado
  String _coords = "COORDS";

  /// Método para obtener las coordenadas actuales
  /// Verifica permisos y muestra diálogos si es necesario
  Future<void> _obtenerCoordenadas() async {
    // Verificar si tenemos permisos de ubicación
    bool hasPermission = await LocationService.checkAndRequestLocationPermission();
    if (!hasPermission) {
      // Si no tenemos permisos y el widget está montado, mostrar diálogo
      if (mounted) {
        await LocationService.showLocationDialog(context);
      }
      return;
    }

    try {
      // Intentar obtener la ubicación actual
      Position? position = await LocationService.getCurrentLocation();
      if (position != null) {
        // Si se obtuvo la ubicación, actualizar el estado con las coordenadas
        setState(() {
          _coords = "Lat: ${position.latitude}, Lng: ${position.longitude}";
        });
      } else {
        // Si no se pudo obtener la ubicación, mostrar mensaje de error
        setState(() {
          _coords = "No se pudo obtener la ubicación";
        });
      }
    } catch (e) {
      // Si ocurre un error, mostrar el mensaje de error
      setState(() {
        _coords = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con el título
      appBar: AppBar(
        backgroundColor: CupertinoColors.activeGreen,
        title: Text(widget.title),
      ),
      // Cuerpo de la pantalla
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto que muestra las coordenadas
            Text(
              _coords,
              style: const TextStyle(
                fontSize: 40, 
                fontWeight: FontWeight.bold, 
                color: Colors.purple
              ),
            ),
            const SizedBox(height: 20),
            // Botón para obtener las coordenadas
            ElevatedButton(
              onPressed: _obtenerCoordenadas,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Obtener Coordenadas',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
