import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';


final appointmentProvider = StateNotifierProvider<AppointmentNotifier, List<Appointment>>((ref) {
  return AppointmentNotifier(ref);
});

class AppointmentNotifier extends StateNotifier<List<Appointment>> {
  final Ref ref;

  AppointmentNotifier(this.ref) : super([]);

  Future<void> loadAppointments() async {
    final appointments = await ref.read(databaseServiceProvider).getAppointments();
    state = appointments;
    syncWithApi();
  }

  Future<void> addAppointment(Appointment appointment) async {
    final id = await ref.read(databaseServiceProvider).insertAppointment(appointment);
    state = [...state, appointment..id = id];
    syncWithApi();
  }

  Future<void> updateAppointment(Appointment appointment) async {
    await ref.read(databaseServiceProvider).updateAppointment(appointment);
    state = [
      for (final a in state)
        if (a.id == appointment.id) appointment else a,
    ];
    syncWithApi();
  }

  Future<void> deleteAppointment(int id) async {
    await ref.read(databaseServiceProvider).deleteAppointment(id);
    state = state.where((a) => a.id != id).toList();
    syncWithApi();
  }

  Future<void> syncWithApi() async {
    final apiService = ref.read(apiServiceProvider);
    final localAppointments = await ref.read(databaseServiceProvider).getAppointments();

    await apiService.syncAppointments(localAppointments);
    final remoteAppointments = await apiService.fetchAppointments();

    state = remoteAppointments;
  }
}