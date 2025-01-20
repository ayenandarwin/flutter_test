import 'package:flutter/material.dart';
import '../models/appointment.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../presentation/map_page.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final Appointment appointment;

  AppointmentDetailScreen({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appointment.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name: ${appointment.customerName}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Company: ${appointment.company}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Description: ${appointment.description}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Date & Time: ${appointment.dateTime}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MapPage(),
                        ),
                      );
                    },
                    child: Text('Pick a location',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Expanded(
            //child: MapScreen()
            // child: MapPage()
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(appointment.latitude, appointment.longitude),
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('appointment_location'),
                  position: LatLng(appointment.latitude, appointment.longitude),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
