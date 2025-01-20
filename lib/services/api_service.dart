import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/appointment.dart';
import 'package:dio/dio.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.100.76:3000'));

  //http://192.168.100.224:3000/appointments

  Future<List<Appointment>> fetchAppointments() async {
    final response = await _dio.get('/appointments');
    return (response.data as List)
        .map((json) => Appointment.fromMap(json))
        .toList();
  }

  Future<void> syncAppointments(List<Appointment> appointments) async {
    for (final appointment in appointments) {
      if (appointment.id == null) {
        await _dio.post('/appointments', data: appointment.toMap());
      } else {
        await _dio.put('/appointments/${appointment.id}', data: appointment.toMap());
      }
    }
  }
}
