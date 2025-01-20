

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment.dart';
import '../provider/appointment_provider.dart';

class AppointmentFormScreen extends ConsumerStatefulWidget {
  @override
  _AppointmentFormScreenState createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends ConsumerState<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String customerName = '';
  String company = '';
  String description = '';
  DateTime? dateTime;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Appointment')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => title = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer Name'),
                onSaved: (value) => customerName = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Company'),
                onSaved: (value) => company = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value ?? '',
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 5, 156, 145), // Set the background color
                  foregroundColor: Colors.white, // Set the text color
                ),
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ref.read(appointmentProvider.notifier).addAppointment(
                          Appointment(
                            title: title,
                            customerName: customerName,
                            company: company,
                            description: description,
                            dateTime: DateTime.now(),
                            latitude: latitude,
                            longitude: longitude,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
