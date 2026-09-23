import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData['login'] ?? 'Profil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network("${userData['image']['link']}"),
            Text('${userData['kind']} ${userData['login']}'),
            Text('${userData['displayname']}'),
            Text('Email : ${userData['email']} '),
            Text('Correction points : ${userData['correction_point']}'),
            Text('')
          ],
        ),
      ),
    );
  }
}