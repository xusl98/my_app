import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/Profile/Edit/emailEdit.dart';
import 'package:my_app/screens/Profile/Edit/licenseEdit.dart';
import 'package:my_app/screens/Profile/Edit/nameEdit.dart';
import 'package:my_app/screens/Profile/Edit/passwordEdit.dart';
import 'package:my_app/screens/Profile/Edit/phoneEdit.dart';
import 'package:my_app/screens/Profile/ProfileOptions/profileEdit.dart';
import 'package:my_app/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  dynamic userData;
  String? userName;
  String? userSurname;
  String? userEmail;
  String? userPhone;
  String? userLicense;

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
      userEmail = userData['email'].toString();
      userPhone = userData['phoneNumber'].toString();
      userLicense = userData['license'].toString() != 'null' ? userData['license'].toString() : '';
    });
  }

  void navigateToEditScreen(String routeName) {
    Navigator.pushNamed(context, routeName);
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${userName} ${userSurname}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  // Aquí iría la imagen recortada para ser redonda
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ProfileInputItem(
                    label: 'Nombre y Apellidos',
                    defaultValue: '$userName $userSurname',
                    routeName: 'NameEditScreen',
                  ),
                  ProfileInputItem(
                    label: 'Email',
                    defaultValue: '$userEmail',
                    routeName: 'EmailEditScreen',
                  ),
                  ProfileInputItem(
                    label: 'Número de teléfono',
                    defaultValue: '$userPhone',
                    routeName: 'PhoneEditScreen',
                  ),
                  ProfileInputItem(
                    label: 'Contraseña',
                    defaultValue: '******',
                    routeName: 'PasswordEditScreen',
                  ),
                  ProfileInputItem(
                    label: 'Número de Licencia REFG',
                    defaultValue: '$userLicense',
                    routeName: 'LicenseEditScreen',
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

class ProfileInputItem extends StatelessWidget {
  final String label;
  final String defaultValue;
  final String routeName;

  const ProfileInputItem({
    required this.label,
    required this.defaultValue,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (routeName) {
          case 'NameEditScreen':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NameEditScreen()),
            );
            break;
          case 'EmailEditScreen':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmailEditScreen()),
            );
            break;
          case 'PhoneEditScreen':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PhoneEditScreen()),
            );
            break;
          case 'PasswordEditScreen':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PasswordEditScreen()),
            );
            break;
          case 'LicenseEditScreen':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LicenseEditScreen()),
            );
            break;
        }
      },
      child: ListTile(
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        subtitle: TextField(
          controller: TextEditingController(text: defaultValue),
          enabled: false,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            hintText: defaultValue,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

