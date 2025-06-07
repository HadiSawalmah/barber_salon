import 'package:flutter/material.dart';
import '../../services/barber_service.dart';

class BarberAvailabilityProvider with ChangeNotifier {
  final BarberServiceAvailability _barberService = BarberServiceAvailability();

  List<String> _availableTimes = [];

  List<String> get availableTimes => _availableTimes;

  void setAvailableTimes(List<String> times) {
    _availableTimes = times;
    notifyListeners();
  }

  Future<void> saveAvailability({
    required String barberId,
    required String date,
  }) async {
    await _barberService.addAvailability(
      barberId: barberId,
      date: date,
      times: _availableTimes,
    );
  }

  Future<List<String>> fetchAvailableDates({required String barberId}) async {
    final dates = await _barberService.getAvailableDates(barberId: barberId);
    return dates;
  }

  Future<void> fetchAvailability({
    required String barberId,
    required String date,
  }) async {
    final data = await _barberService.getAvailability(
      barberId: barberId,
      date: date,
    );
    if (data != null) {
      _availableTimes = List<String>.from(data['times']);
    } else {
      _availableTimes = [];
    }
    notifyListeners();
  }
}
