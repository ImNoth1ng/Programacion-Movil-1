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
  /// Controlador para el campo de texto de coordenadas
  final TextEditingController _coordsController = TextEditingController();
  /// Texto que muestra el estado actual
  String _statusMessage = "COORDS";

  @override
  void dispose() {
    // Limpiar el controlador cuando el widget se destruye
    _coordsController.dispose();
    super.dispose();
  }

  /// Método para obtener las coordenadas actuales
  /// Verifica permisos y muestra diálogos si es necesario
  Future<void> _obtenerCoordenadas() async {
    bool hasPermission = await LocationService.checkAndRequestLocationPermission();
    if (!hasPermission) {
      if (mounted) {
        await LocationService.showLocationDialog(context);
      }
      return;
    }

    try {
      Position? position = await LocationService.getCurrentLocation();
      if (position != null) {
        setState(() {
          _statusMessage = "Coordenadas obtenidas";
          // Formatear las coordenadas con 6 decimales y separadas por coma
          _coordsController.text = "${position.latitude.toStringAsFixed(6)},${position.longitude.toStringAsFixed(6)}";
        });
      } else {
        setState(() {
          _statusMessage = "No se pudo obtener la ubicación";
          _coordsController.clear();
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Error: $e";
        _coordsController.clear();
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
            // Texto de estado
            Text(
              _statusMessage,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple
              ),
            ),
            const SizedBox(height: 20),
            // Etiquetas de latitud y longitud
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Lat: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Long: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Campo de texto para las coordenadas
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _coordsController,
                readOnly: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: "Coordenadas...",
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botón para obtener coordenadas
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
