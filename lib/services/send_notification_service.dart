import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

Future<String> getAccessToken() async {
  final jsonString = {

  };

  
  try {
    final accountCredentials = auth.ServiceAccountCredentials.fromJson(
      jsonString,
    );

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    final client = await auth.clientViaServiceAccount(
      accountCredentials,
      scopes,
    );

    client.close();

    return client.credentials.accessToken.data;
  } catch (e, stacktrace) {
    log("Failed to get access token: $e");
    log("Stacktrace: $stacktrace");
    rethrow;
  }
}

Future<void> sendNotification(String token, String title, String body) async {
  log("send Notification -reservation is confirm");
  final String accessToken = await getAccessToken();
  final String fcmUrl ;

  final response = await http.post(
    Uri.parse(fcmUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, dynamic>{
      'message': {
        'token': token,
        'notification': {'title': title, 'body': body},
        "data": {'title': title, 'body': body},
      },
    }),
  );

  if (response.statusCode == 200) {
    log('Notification sent successfully');
  } else {
    log('Failed to send notification: ${response.body}');
  }
}
