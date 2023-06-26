import 'package:flutter/material.dart';
import 'package:my_app/resources/themeColors.dart';
import 'package:my_app/screens/register.dart';
import 'package:my_app/services/userService.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '880024356807-e6rchm26si9p9n14up681dckbkhulkru.apps.googleusercontent.com',
  );
  

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
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;

                  bool loggedIn = await loginUser(email, password);
                  if (loggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }

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
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    // Handle Google sign in
                    try {
                      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
                      final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;

                      final String email = googleSignInAccount.email;
                      //TODO ahora obtener el apikey a partir del email y guardarlo, despues hacer lo mismo para sign up, y que tras esto te lleve a las siguientes paginas de registro para añadir el resto de datos
                      print('Email: $email');
                    } catch (error) {
                      print(error);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Customize button color
                  ),
                  icon: Icon(Icons.android), // Google logo
                  label: Text('Sign in with Google'),
                ),
                SizedBox(width: 10.0),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle iOS sign in
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Customize button color
                  ),
                  icon: Icon(Icons.apple), // Apple logo
                  label: Text('Sign in with iOS'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
