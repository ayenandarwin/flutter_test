import 'package:flutter/material.dart';

import '../models/appointment.dart';
import 'appointment_detail_screen.dart';

class AppointmentSearchDelegate extends SearchDelegate {
  final List<Appointment> appointments;

  AppointmentSearchDelegate(this.appointments);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = appointments.where((appointment) {
      return appointment.title.toLowerCase().contains(query.toLowerCase()) ||
          appointment.customerName.toLowerCase().contains(query.toLowerCase()) ||
          appointment.company.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final appointment = results[index];
        return ListTile(
          title: Text(appointment.title),
          subtitle: Text('${appointment.customerName} - ${appointment.company}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AppointmentDetailScreen(appointment: appointment),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}