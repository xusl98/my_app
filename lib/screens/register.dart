import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/themeColors.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool checkedInfo = false;
  bool checkedTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrap RegisterScreen with Scaffold
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
              decoration: InputDecoration(
                labelText: 'Nombre y Apellidos',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Número de licencia RFEG',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text(
                  "Acepto a recibir comunicaciones comerciales con ofertas que puedan ser de mi interés procedentes de terceras empresas con las que Golf clap haya llegado a un acuerdo comercial.",
                  style: TextStyle(fontSize: 13)),
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
                  style: TextStyle(fontSize: 13)),
              value: checkedTerms,
              onChanged: (newValue) {
                setState(() {
                  checkedTerms = newValue ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            ElevatedButton(
              onPressed: () {
                // Acción a realizar al presionar el botón Finalizar
              },
              child: Text('Finalizar'),
            ),
          ],
        ),
      ),
    );
  }
}
