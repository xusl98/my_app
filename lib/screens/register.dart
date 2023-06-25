import 'package:flutter/material.dart';
import '../resources/themeColors.dart';
import '../services/userService.dart';

import 'home.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool checkedInfo = false;
  bool checkedTerms = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 80, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Ya no queda nada...",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            TextFormField(
              controller: surnameController,
              decoration: InputDecoration(
                labelText: 'Apellidos',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            TextFormField(
              controller: userNameController,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: licenseNumberController,
              decoration: InputDecoration(
                labelText: 'Número de licencia RFEG',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text(
                "Ya tengo una cuenta",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
            CheckboxListTile(
              title: Text(
                "Acepto a recibir comunicaciones comerciales con ofertas que puedan ser de mi interés procedentes de terceras empresas con las que Golf clap haya llegado a un acuerdo comercial.",
                style: TextStyle(fontSize: 13),
              ),
              value: checkedInfo,
              onChanged: (newValue) {
                setState(() {
                  checkedInfo = newValue ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text(
                "Estoy de acuerdo con los Términos y Condiciones y Política de Privacidad.",
                style: TextStyle(fontSize: 13),
              ),
              value: checkedTerms,
              onChanged: (newValue) {
                setState(() {
                  checkedTerms = newValue ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String surname = surnameController.text;
                String userName = userNameController.text;
                String licenseNumber = licenseNumberController.text;
                String phone = phoneController.text;
                String email = emailController.text;
                String password = passwordController.text;

                // Use the values as needed
                // Example: Print the values
                print('Name: $name');
                print('Surname: $surname');
                print('UserName: $userName');
                print('License Number: $licenseNumber');
                print('Email: $email');
                print('Phone: $phone');
                print('Password: $password');
                print('Checked Info: $checkedInfo');
                print('Checked Terms: $checkedTerms');
                if (checkedTerms) {
                  // TODO: Añadir selector de país
                  bool registered = await registerUser(
                    name,
                    surname,
                    userName,
                    licenseNumber,
                    email,
                    phone,
                    password,
                    "ES",
                  );
                  if (registered) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                } else {
                  // TODO: Indicar al usuario que debe aceptar los términos de uso
                }
              },
              child: Text('Finalizar'),
            ),
          ],
        ),
      ),
    );
  }
}
