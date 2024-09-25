import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          //child: Image.asset(),
        ),
        Container(
          child: Text('Makhmadiyorov Bekhruz'),
        ),
       const Row(
          children: [
            Icon(Icons.edit),
            Text('Edit profile'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.password),
            Text('Change Password'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.info),
            Text('Information'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.recycling),
            Text('Update programm'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.logout),
            Text('Log out'),
          ],
        )
      ],
    );

  }
}
