import 'package:flutter/material.dart';

class ProfileConfigurationScreen extends StatefulWidget {
  @override
  _ProfileConfigurationScreenState createState() => _ProfileConfigurationScreenState();
}

class _ProfileConfigurationScreenState extends State<ProfileConfigurationScreen> {
  bool trackingEnabled = false;

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
                'Configuración de seguimiento y privacidad',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Golf Clapp requiere permisos de seguimiento de tu actividad para brindarte contenido y anuncios personalizados.' + 
                  '\n\nEsta aplicación requiere que autorices el seguimiento de tu actividad para ofrecerte una mejor experiencia, ' +
                  'con tu contenido y anuncio personalizados',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Switch(
                    value: trackingEnabled,
                    onChanged: (value) {
                      setState(() {
                        trackingEnabled = value;
                      });
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Seguimiento habilitado',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
