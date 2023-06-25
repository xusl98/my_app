import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/Profile/ProfileOptions/profileConfiguration.dart';
import 'package:my_app/screens/Profile/ProfileOptions/profileEdit.dart';
import 'package:my_app/screens/Profile/ProfileOptions/profileFAQ.dart';
import 'package:my_app/screens/Profile/ProfileOptions/profileFriends.dart';
import 'package:my_app/screens/Profile/ProfileOptions/profileLegal.dart';
import 'package:my_app/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            GestureDetector(
              onTap: () {
                // Acción al hacer clic en "Editar Perfil"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                );
              },
              child: Text(
                'Editar Perfil',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ProfileListItem(
                    icon: Icons.people,
                    text: 'Amigos',
                    name: 'Friends',
                  ),
                  ProfileListItem(
                    icon: Icons.payment,
                    text: 'Método de pago',
                    name: 'PaymentMethod',
                  ),
                  ProfileListItem(
                    icon: Icons.calendar_today,
                    text: 'Reservas',
                    name: 'Booking',
                  ),
                  ProfileListItem(
                    icon: Icons.description,
                    text: 'Legal',
                    name: 'Legal',
                  ),
                  ProfileListItem(
                    icon: Icons.help_outline,
                    text: 'FAQs',
                    name: 'FAQs',
                  ),
                  ProfileListItem(
                    icon: Icons.settings,
                    text: 'Configuración de seguimiento y privacidad',
                    name: 'Configuration',
                  ),
                  ProfileListItem(
                    icon: Icons.logout,
                    text: 'Cerrar Sesión',
                    name: 'LogOut',
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

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String name;

  const ProfileListItem({
    required this.icon,
    required this.text,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      onTap: () async {
        switch (name) {
          case 'LogOut':
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('apiKey');
            prefs.remove('user');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
            break;
            case 'Legal':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileLegalScreen(),
              ),
            );
            break;
            case 'FAQs':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileFAQScreen(),
              ),
            );
            break;
            case 'Configuration':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileConfigurationScreen(),
              ),
            );
            break;
            case 'Friends':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileFriendsScreen(),
              ),
            );
            break;
        }
      },
    );
  }
}
