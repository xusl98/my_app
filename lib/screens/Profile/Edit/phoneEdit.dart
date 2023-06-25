import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/userService.dart';

class PhoneEditScreen extends StatefulWidget {
  @override
  _PhoneEditScreenState createState() => _PhoneEditScreenState();
}

class _PhoneEditScreenState extends State<PhoneEditScreen> {
  dynamic userData;
  String? userApiKey;
  String? userPhone;
  String? userCountry;
  PhoneNumber number = new PhoneNumber();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'US';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    userData = await GetUserData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userApiKey = prefs.getString('apiKey');
    setState(() {
      print('---');
      print(userData);
      userPhone = userData['phoneNumber'].toString();
      userCountry = userData['country'].toString();
      print(userPhone);
      number = PhoneNumber(isoCode: userCountry, phoneNumber: userPhone);
      controller.text = number.phoneNumber!;
      print(number);
      //TODO make service for sharedReference so that I dont have to convert to JSON every time, also see if i can save variables between classes
    });
  }

  Future<void> updateData() async {
    // Código para realizar la llamada POST a la API con los datos actualizados
    try {
      // Construye el cuerpo de la solicitud
      Map<String, dynamic> requestBody = {
        'phone': userPhone,
      };

      // print(number.toString());

      // Realiza la llamada POST a la API
      var response = await http.post(
        Uri.parse('https://localhost:7294/Account/UpdateName'),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json', 'Api-Key': userApiKey!},
      );

      // Verifica el código de respuesta de la API
      if (response.statusCode == 200) {
        // La solicitud se realizó correctamente
        // Puedes realizar acciones adicionales después de actualizar los datos
        print('Datos actualizados con éxito');
      } else {
        // Hubo un error al realizar la solicitud
        print('Error al actualizar los datos');
      }
    } catch (error) {
      // Hubo un error en la comunicación con la API
      print('Error de conexión');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.only(bottom: 16), // Margen por debajo del texto
                child: Text(
                  'Personaliza tu experiencia',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print('--');
                  print(number.phoneNumber);
                  userPhone = number.phoneNumber;
                  print('--');
                },
                onInputValidated: (bool value) {
                  // print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: controller,
                formatInput: true,
                keyboardType: TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                inputBorder: OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 44),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      updateData();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Actualizar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
