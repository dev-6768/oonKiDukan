import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_gardening_app/firebase_class/FirebaseControllers.dart';

Future<String> sendQuestionData(String question, String url) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': "application/json",     //'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Access-Control-Allow-Credentials': "true",
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Accept":"*/*",
      "Accept-Encoding":"gzip, deflate, br",
      "Connection":"keep-alive",
    },
    body: jsonEncode(<String, String>{
      "question": question,
    }),
  );

  if(response.statusCode == 201 || response.statusCode == 200) {
    utilFunctions.toastMessageService("Successfully sent question. Waiting for response...");
    Map jsonMap = jsonDecode(response.body);
    return jsonMap['data'];
  }

  else {
    print(response.statusCode);
    utilFunctions.toastMessageService("Failed to send question. Please try again later.");
    throw Exception("Failed to send question. Please try again later.");
  }
}

Future<http.Response> fetchQuestionData(String url) async {
  final response = await http
      .get(Uri.parse(url));

  if (response.statusCode == 200) {
    utilFunctions.toastMessageService("Successfully received content");
    print(jsonDecode(response.body));
    return jsonDecode(response.body);

  } else {
    utilFunctions.toastMessageService("Failed to get data. Please try again later.");
    throw Exception('Failed to load album');
  }
}


