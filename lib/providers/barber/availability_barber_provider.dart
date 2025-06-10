import 'package:flutter/material.dart';
import '../../services/barber_service.dart';

class BarberAvailabilityProvider with ChangeNotifier {
  final BarberServiceAvailability _barberService = BarberServiceAvailability();

  List<String> _availableTimes = [];
  List<String> _unavailableTimes = [];

  List<String> get availableTimes => _availableTimes;
  List<String> get unavailableTimes => _unavailableTimes;
  void setAvailableTimes(List<String> times) {
    _availableTimes = times;
    notifyListeners();
  }

  void setUnavailableTimes(List<String> times) {
    _unavailableTimes = times;
    notifyListeners();
  }

  void moveToUnavailable(String time) {
    _availableTimes.remove(time);
    _unavailableTimes.add(time);
    notifyListeners();
  }

  void moveToAvailable(String time) {
    _unavailableTimes.remove(time);
    _availableTimes.add(time);
    notifyListeners();
  }

  void clearAvailability(List<String> time) {
    _unavailableTimes.addAll(_availableTimes);
    _availableTimes.clear();
    notifyListeners();
  }

  Future<void> saveAvailability({
    required String barberId,
    required String date,
  }) async {
    await _barberService.addAvailability(
      barberId: barberId,
      date: date,
      availableTimes: _availableTimes,
      unavailableTimes: _unavailableTimes,
    );
  }

  Future<List<String>> fetchAvailableDates({required String barberId}) async {
    final dates = await _barberService.getAvailableDates(barberId: barberId);
    return dates;
  }

  Future<void> fetchAvailability({
    required String barberId,
    required String date,
    required List<String> allTimes,
  }) async {
    final data = await _barberService.getAvailability(
      barberId: barberId,
      date: date,
    );

    if (data != null &&
        data['availableTimes'] != null &&
        data['unavailableTimes'] != null) {
      _availableTimes = List<String>.from(data['availableTimes']);
      _unavailableTimes = List<String>.from(data['unavailableTimes']);
    } else {
      _availableTimes = List.from(allTimes);
      _unavailableTimes = [];
    }
    notifyListeners();
  }
}
