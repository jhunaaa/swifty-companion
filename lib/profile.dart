import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    double level = 0.0;
    if (userData['cursus_users'] != null && (userData['cursus_users'] as List).isNotEmpty) {
      var lastCursus = userData['cursus_users'].last;
      level = double.tryParse(lastCursus['level']?.toString() ?? '') ?? 0.0;
    }
    int pourcent = (level.remainder(1) * 100).round();

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
                Image.network("${userData['image']['versions']['large']}",
                  width: 140, height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset('assets/default.png', width: 140, height: 140, fit: BoxFit.cover,);
                    },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userData['kind']} ${userData['login']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person_search, size: 18),
                          const SizedBox(width: 6),
                          Expanded(child: Text('${userData['displayname']}')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.mail, size: 18),
                          const SizedBox(width: 6),
                          Expanded(child: Text('${userData['email']}')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.local_phone_rounded, size: 18),
                          const SizedBox(width: 6),
                          Expanded(child: Text('Phone : ${userData['phone']}')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.school, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Campus : ${userData['campus'] != null && userData['campus'].isNotEmpty ? userData['campus'][0]['name'] : 'N/A'}',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            ),
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: pourcent / 100,
                      heightFactor: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Level ${level.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// test : zekaold, brownie, 42