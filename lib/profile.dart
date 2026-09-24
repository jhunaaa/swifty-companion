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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network("${userData['image']['versions']['large']}", width: 140, height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset('assets/default.png', width: 150, height: 150, fit: BoxFit.cover,);
                    },
                ),
                Expanded(
                  child: Text(
                    '${userData['kind']} ${userData['login']}\n'
                        '${userData['displayname']}\n'
                        'Email :\n${userData['email']}\n'
                        'Correction points : ${userData['correction_point']}\n'
                        'phone : ${userData['phone']}',
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}