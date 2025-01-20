import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static LatLng? center = const LatLng(22.211174451826803, 95.186509299462);
  Completer<GoogleMapController> _controller = Completer();
  String? _currentAddress;
  Position? _currentPosition;
  MapType _currentMapType = MapType.normal;

  // Function to handle the map creation
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // Function to handle the location permission and get the current position
  Future<void> _getCurrentPosition() async {
    // Request for location permission
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle the denied permission (inform the user, etc.)
      return;
    }

    // If permission is granted, get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      center = LatLng(position.latitude,
          position.longitude); // Update center to the current location
    });
  }

  // Toggle map type between normal and satellite
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: GoogleMap(
        mapType: _currentMapType,
        myLocationEnabled: true, // Enable MyLocation button
        myLocationButtonEnabled: true, // Show the MyLocation button
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center!,
          zoom: 11.0,
        ),
        // Update the camera position when the user's location is available
        onCameraMove: (CameraPosition position) {
          if (_currentPosition != null) {
            _controller.future.then((controller) {
              controller.animateCamera(CameraUpdate.newLatLng(center!));
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: const Icon(Icons.location_on),
        onPressed: () {
          // Get the current position when the button is pressed
          _getCurrentPosition();
        },
      ),
    );
  }
}
