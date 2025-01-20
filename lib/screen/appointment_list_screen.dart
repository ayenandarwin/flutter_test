import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment.dart';
import '../provider/appointment_provider.dart';

import 'appointment_detail_screen.dart';
import 'appointment_form_screen.dart';
import 'appointment_search_screen.dart';

class AppointmentListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentProvider);
    final appointmentNotifier = ref.read(appointmentProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 5, 156, 145),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: AppointmentSearchDelegate(appointments),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Card(
              child: ListTile(
                title: Text(appointment.title),
                subtitle: Text(
                    '${appointment.customerName} - ${appointment.company}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 5, 156, 145),
                      ),
                      onPressed: () =>
                          appointmentNotifier.updateAppointment(appointment),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => appointmentNotifier
                          .deleteAppointment(appointment.id!),

                      // onPressed: () => _deleteAppointment(appointment.id!),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AppointmentDetailScreen(appointment: appointment),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 5, 156, 145),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AppointmentFormScreen(),
            ),
          );
        },
      ),
    );
  }
}
