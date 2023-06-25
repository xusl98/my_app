import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/userService.dart';

class NameEditScreen extends StatefulWidget {
  @override
  _NameEditScreenState createState() => _NameEditScreenState();
}

class _NameEditScreenState extends State<NameEditScreen> {
  dynamic userData;
  String? userApiKey;
  String? userName;
  String? userSurname;

  Key nameKey = UniqueKey();
  Key surnameKey = UniqueKey();
  TextEditingController? nameController;
  TextEditingController? surnameController;

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
      userName = userData['name'].toString();
      userSurname = userData['surname'].toString();
      nameController = TextEditingController(text: userName);
      surnameController = TextEditingController(text: userSurname);
      //TODO make service for sharedReference so that I dont have to convert to JSON every time, also see if i can save variables between classes
    });
  }

  Future<void> updateData() async {
    // Código para realizar la llamada POST a la API con los datos actualizados
    try {
      // Construye el cuerpo de la solicitud
      Map<String, dynamic> requestBody = {
        'name': userName,
        'surname': userSurname,
      };

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
            mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nombre',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Este es el nombre que te gustaría que usaran otras personas para dirigirse a ti',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nombre',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  key: nameKey,
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      userName = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 24),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Apellidos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  key: surnameKey,
                  controller: surnameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      userSurname = value;
                    });
                  },
                ),
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
