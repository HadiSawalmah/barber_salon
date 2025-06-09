import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

Future<String> getAccessToken() async {
  final jsonString = {
    "type": "service_account",
    "project_id": "salon-albasha",
    "private_key_id": "7f2dec7bd19707eeead3549be85bfe69157533dc",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDbvr7kqxaTW2da\n74fSQZaNCKBMgFl8b/IAf0DY+EBYpTJbvibE86iuJps0KZivoMl4jqppt/z7NYfz\nygi/Sf8J9j0Hk1ZCwmpz6rujtFEx3wM3iK5xEVr+3N91mkxanmE3aiW82ksc+rhE\ngTlMDqP4dMKXwMZhEgsCeGINfkUBgiEY8TPwURmunir7m6juQIn+KFZZmP0r7+u2\nN0OfnYvjFkNKP4CVr/7PSsvfQpMero1C933hO8VKF7I0/gek+9cf0HPrSaPkWqV4\np9zvyXqH3VqdFYRTyjZiPkUt/Hf18gaaA0sdtdz69MxsEFra8cBmYMoDfP3l87mk\n4kLnNBsnAgMBAAECggEADA9JJH1boeutKoYk/JeH5SaSvlze5flMA6LFBgNRBYYC\noDSGP5HY8Vg1QiTneCzWHo0p2HjcY+1mQ2CUbIPpmmJ1EZWqJF2aGdF8lpMYHHYP\nFAmmyGLGjS0rzSVe+/j5AEfaWVjblw2oqW3NtxkomF0EEiL/+cAG2NrCR6Sx5QKx\n6wC1uNPl+F7DkCM//Chlzq9L/p6D7x3FYlFMV6zioJKKbg9DBPZgjBUvXlfM3Z8K\n0ewMYVlBzYPF8fudLMFmamQykA3cFehR+1KnJjbNWsPY5PxE5nq7eRJnsyPdsu88\nKkvQ6BoBPCQRoUqf+DaJi3+MtoqtVAkEWtpFLBrVcQKBgQDxIz0tXguqC+EK/h6A\nhB+WVPzjmlW2UScrw0lr9tTUMJTTHAHZ4JINa4nnGNzK6RHSmRrXRD8UVFUBJZ9F\noXcEdFoKNJYrnrBTwWEF3FnAg1Scz+9YyROO2VsTUl3brUtkvgJdyFEfa963aHpu\nN2/MfZvdDaaSUITUwwBg5kNAcQKBgQDpSfeI4NzbV42BcAg2qAoFcSHcvBScGazc\n5a1jUPqa2j7jXYRJwa4J7VBRRjQ+IgRNUy+DoVj3vWIocoAXv3KTS4I+54/g+ZH8\nGhhzCjcmmX3s7MZ9HRXZXW+Vw9IVGwnm5fLDRjJRCHhbez5Q8A6r4iSiuykWK9Us\n2dZvlubhFwKBgQDuM5REU4mMMe3dcQfqhhm55DxoDVYsImBib6gAubSl41OwcxM1\nCgzcquVv3vSEkNWlRs7n5Se2ylOqLWL3YrfyM4maWTYa4shmBDn2kyQp8tHLkfBq\nsT7btsSsAopq7fXzD2vA/pd8RY+dd9yxMZwD0fT82XY5RMbicbrW/b9jUQKBgD2r\nxRlVQG1ntsvJ/xHb2FJZ9vawbc5aZz06Jl0D8kvveAKJHUiWP9j1+G6T3YmzWmnK\nnNvyUl+jnAhPRJeCj9pqcrMIahuyPipkB6SZxbyZhRWV/l7iynzc23u++ZGExVhZ\n35RJwVF0qMSeTvn8jBRaQw8V5SWsTr19lNeJD93fAoGBAOeUSpsaO5OrHbpBMQVu\n1vDEGudm4ob5Pp3Vcc+B9/ZqqV3myYQbAAYP7dHgPHCb5O/JDVKgdkMuNNqc8Y09\nQAIZirCxplk4cd4GjKycxk5K3SxvaOd381pl6tsSW0q68d/T2QGvfKJWdH9bsMWO\nxdWfrrD3O3yePQqrGUBfesQq\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-fbsvc@salon-albasha.iam.gserviceaccount.com",
    "client_id": "104337722908645794418",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40salon-albasha.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com",
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
  final String fcmUrl =
      'https://fcm.googleapis.com/v1/projects/salon-albasha/messages:send';

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
