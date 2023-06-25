import 'package:flutter/material.dart';

class ProfileFriendsScreen extends StatefulWidget {
  @override
  _ProfileFriendsScreenState createState() => _ProfileFriendsScreenState();
}

class _ProfileFriendsScreenState extends State<ProfileFriendsScreen> {
  List<String> friendNames = ['Amigo 1', 'Amigo 2', 'Amigo 3', 'Amigo 4', 'Amigo 5', 'Amigo 6']; // Lista de nombres de amigos

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                'Amigos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16), // Agregar margen inferior
                child: Text(
                  'Aquí puedes ver tus amigos de Golf Clapp',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: friendNames.map((friendName) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - 80) / 5, // Dividir el ancho disponible por 5
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/avatar.png'), // Reemplaza 'assets/images/avatar.png' con la ruta de tu imagen
                        ),
                        SizedBox(height: 8),
                        Text(
                          friendName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
