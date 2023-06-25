import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/resources/themeColors.dart';
import 'package:my_app/screens/register.dart';
import 'package:my_app/screens/welcome.dart';
import 'package:my_app/services/userService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  log('1');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log(DefaultFirebaseOptions.currentPlatform.toString());
  log('2');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Encantados de verte de nuevo!',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password action
                },
                child: Text('¿Olvidaste tu contraseña?'),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String email = emailController.text;
                  String password = passwordController.text;

                  loginUser(email, password);

                  // Make the POST request to the API
                  // Use the email and password variables in the request

                  // Example API call:
                  // myApi.postLogin(email, password);
                },
                style: ElevatedButton.styleFrom(
                  primary: ThemeColors.buttonBackgroundColor,
                ),
                child: Text('Entrar'),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('¿Aún no tienes cuenta?'),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Navigate to RegisterScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Regístrate aquí',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
