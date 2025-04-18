import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class CoordsScreen extends StatefulWidget {
  const CoordsScreen({super.key, required this.title});

  final String title;

  @override
  State<CoordsScreen> createState() => _CoordsScreenState();
}

class _CoordsScreenState extends State<CoordsScreen> {


  String _Coords = "COORDS";

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.activeGreen,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(
            _Coords,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          MaterialButton(
            onPressed: () async {
              try { Position position = await _determinePosition(); setState(() { _Coords = "Lat: ${position.latitude}, Lng: ${position.longitude}"; }); print("Lat: ${position.latitude}, Lng: ${position.longitude}"); } catch (e) { setState(() { _Coords = "Error: $e"; }); print("Error: $e"); }
            },
            child: const Text('Obtener Coordenadas'),
          ),
        ],
      ),
    );
  }
}
