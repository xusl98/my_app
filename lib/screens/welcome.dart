import 'package:flutter/material.dart';
import 'package:my_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 80), // Adjust the height of the text
                child: Text(
                  'Golf Clapp',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () async {
                  // Retrieve data
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? apiKey = prefs.getString('apiKey');
                  print(apiKey);
                  if (apiKey != null && apiKey != '') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Set button background color to black
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
