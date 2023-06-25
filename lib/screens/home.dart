import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic userData;
  String? userName;
  String? userSurname;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    print(prefs.getString('user'));
    userData = convertToUserJSON(prefs.getString('user')!);
    userName = userData['name'].toString();
    userSurname = userData['surname'].toString();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Golf Clapp',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            onPressed: () {
              // Acción al hacer clic en el ícono de casa
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hola ${userName} ${userSurname},',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '¿Echamos unas bolas?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Acción al hacer clic en "Crear Partida"
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Text('Crear Partida'),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Acción al hacer clic en "Unirse a Partida"
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Text('Unirse a Partida'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
