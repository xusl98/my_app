import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

Future<void> loginUser(String email, String password) async {
  // String apiUrl = FlutterConfig.get('API_URL');
  // String url = '$apiUrl/Account/Login';
  String url = 'https://localhost:7294/Account/Login';
  Map<String, String> headers = {'Content-Type': 'application/json'};

  // Create the request body as a JSON string
  String requestBody = '{"userName": "$email", "password": "$password"}';

  // Make the POST request
  http.Response response = await http.post(Uri.parse(url), headers: headers, body: requestBody);

  // Get the response data
  String responseData = response.body;
  int statusCode = response.statusCode;

  // Handle the response
  if (statusCode == 200) {
    // Successful response
    print('Response: $responseData');
  } else {
    // Error occurred
    print('Error: $statusCode - $responseData');
  }
}
Future<void> registerUser(String name, String surname, String userName, String licenseNumber, String email, String phone, String password, String country) async {
  // String apiUrl = FlutterConfig.get('API_URL');
  // String url = '$apiUrl/Account/Login';
  String url = 'https://localhost:7294/Account/Register';
  Map<String, String> headers = {'Content-Type': 'application/json'};

  // Create the request body as a JSON string
  String params = '?name=$name&userName=$userName&surname=$surname&password=$password&email=$email&phone=$phone&country=$country';
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
    print('Response: $responseData');
  } else {
    // Error occurred
    print('Error: $statusCode - $responseData');
  }
}