import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> loginUser(String email, String password) async {
  // String apiUrl = FlutterConfig.get('API_URL');
  // String url = '$apiUrl/Account/Login';
  String url = 'https://localhost:7294/Account/Login';
  Map<String, String> headers = {'Content-Type': 'application/json'};

  // Create the request body as a JSON string
  String requestBody = '{"userName": "$email", "password": "$password"}';

  // Make the POST request
  http.Response response =
      await http.post(Uri.parse(url), headers: headers, body: requestBody);

  // Get the response data
  String responseData = response.body;
  int statusCode = response.statusCode;

  // Handle the response
  if (statusCode == 200) {
    // Successful response
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonResponse = json.decode(response.body);


    prefs.setString('apiKey', jsonResponse['apiKey'].toString());
    prefs.setString('user', jsonResponse['user'].toString());
    return true;
  } else {
    // Error occurred
    print('Error: $statusCode - $responseData');
    return false;
  }
}

Future<bool> registerUser(
    String name,
    String surname,
    String userName,
    String licenseNumber,
    String email,
    String phone,
    String password,
    String country) async {
  // String apiUrl = FlutterConfig.get('API_URL');
  // String url = '$apiUrl/Account/Login';
  String url = 'https://localhost:7294/Account/Register';
  Map<String, String> headers = {'Content-Type': 'application/json'};

  // Create the request body as a JSON string
  String params =
      '?name=$name&userName=$userName&surname=$surname&password=$password&email=$email&phone=$phone&country=$country';
  url += params;
  // String requestBody = '{"userName": "$userName", "password": "$password", "name": "$name", "surname": "$surname", "email": "$email", "phone": "$phone", "country": "$country", "license": "$licenseNumber"}';

  // Make the POST request
  http.Response response = await http.post(Uri.parse(url), headers: headers);

  // Get the response data
  String responseData = response.body;

  int statusCode = response.statusCode;

  // Handle the response
  if (statusCode == 200) {
    // Successful response

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonResponse = json.decode(response.body);

    prefs.setString('apiKey', jsonResponse['apiKey'].toString());
    prefs.setString('user', jsonResponse['user'].toString());

    String? username = prefs.getString('username');
    print('Response:' + jsonResponse["apiKey"]);
    print('Response: $responseData');
    return true;
  } else {
    // Error occurred
    print('Error: $statusCode - $responseData');
    return false;
  }
}

Future<dynamic> GetUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return convertToUserJSON(prefs.getString('user')!);
}

Map<String, dynamic> convertToUserJSON(String text) {
  // Elimina los espacios en blanco alrededor de las claves y valores
  text = text.replaceAll(RegExp(r'\s*:\s*'), ':').replaceAll(RegExp(r'\s*,\s*'), ',');

  // Elimina los caracteres de llaves al inicio y al final si existen
  if (text.startsWith('{') && text.endsWith('}')) {
    text = text.substring(1, text.length - 1);
  }

  // Divide el texto en pares clave-valor
  List<String> keyValuePairs = text.split(',');

  // Crea un mapa para almacenar los datos
  Map<String, dynamic> jsonMap = {};

  // Recorre cada par clave-valor y los agrega al mapa JSON
  for (String pair in keyValuePairs) {
    List<String> keyValue = pair.split(':');
    String key = keyValue[0].trim();
    String value = keyValue[1].trim();
    jsonMap[key] = value;
  }

  return jsonMap;
}
