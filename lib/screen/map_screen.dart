import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  late CameraPosition _initialPosition;
  late LatLng _pickedLocation;

  @override
  void initState() {
    super.initState();
    _pickedLocation = LatLng(37.7749, -122.4194); // Default to San Francisco
    _initialPosition = CameraPosition(target: _pickedLocation, zoom: 14);
  }

  // Function to get the current location
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _pickedLocation = LatLng(position.latitude, position.longitude);
      _mapController.animateCamera(CameraUpdate.newLatLng(_pickedLocation));
    });
  }

  // Function to handle map tap and pick location
  void _onMapTapped(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
    // You can show a marker or save the location
    _mapController.animateCamera(CameraUpdate.newLatLng(location));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick a Location')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: _onMapTapped, // Handle map tap
            markers: {
              Marker(
                markerId: MarkerId('pickedLocation'),
                position: _pickedLocation,
                infoWindow: InfoWindow(title: 'Picked Location'),
              ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
