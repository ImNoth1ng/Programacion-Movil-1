import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


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
