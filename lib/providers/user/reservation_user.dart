import 'package:cloud_firestore/cloud_firestore.dart';

final String barberId = 'RRyPZ9UyH5dXqf8b58Ewleh0Iz1';
final DateTime selectedDate = DateTime.now();

Future<List<String>> fetchAvailableTimes() async {
  try {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(barberId)
            .collection('availability')
            .doc(selectedDate.timeZoneName)
            .get();

    if (snapshot.exists && snapshot.data() != null) {
      List<dynamic> times = snapshot.get('times');
      return List<String>.from(times);
    } else {
      return []; // no times available
    }
  } catch (e) {
    print("Error fetching times: $e");
    return [];
  }
}
