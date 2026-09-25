import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? cursusSelected;

  @override
  void initState() {
    super.initState();
    if (widget.userData['cursus_users'] != null &&
        (widget.userData['cursus_users'] as List).isNotEmpty) {
      cursusSelected = (widget.userData['cursus_users'] as List).first;
    }
  }
  var cursusIdSelected = 0;

  @override
  Widget build(BuildContext context) {
    double level = double.tryParse(cursusSelected?['level']?.toString() ?? '') ?? 0.0;
    int pourcent = (level.remainder(1) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userData['login'] ?? 'Profil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network("${widget.userData['image']['versions']['large']}",
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
                        '${widget.userData['kind']} ${widget.userData['login']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person_search, size: 18),
                          const SizedBox(width: 6),
                          Expanded(child: Text('${widget.userData['displayname']}')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.mail, size: 18),
                          const SizedBox(width: 6),
                          Expanded(child: Text('${widget.userData['email']}')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.local_phone_rounded, size: 18),
                          const SizedBox(width: 6),
                          Expanded(child: Text('Phone : ${widget.userData['phone']}')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.school, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Campus : ${widget.userData['campus'] != null && widget.userData['campus'].isNotEmpty ? widget.userData['campus'][0]['name'] : 'N/A'}',
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
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 10,
                width: double.infinity,
              ),
            ),

            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                if (widget.userData['cursus_users'] != null)
                  for (var item in (widget.userData['cursus_users'] as List))
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            Colors.blue.shade200),
                      ),
                      onPressed: () {
                        setState(() {
                          cursusSelected = item;
                          cursusIdSelected = item['cursus_id'];
                        });
                      },
                      child: Text("${item['cursus']['name']}"),
                    ),
              ],
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
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Level ${level.toStringAsFixed(2)} ',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 10,
                width: double.infinity,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (widget.userData['cursus_users'] != null && cursusSelected != null)
                  for (var item in (widget.userData['projects_users'] as List))
                    if ((item['cursus_ids'] as List?)?.firstOrNull == cursusIdSelected)
                      if (item['status'] == "finished")
                        Text(
                          "${item['project']['name']} ${item['validated?'] == true ? 'validated' : 'failed'} at ${item['final_mark'] ?? 0}",
                        )
                      else
                        Text("${item['project']['name']} in progression..."),
              ],
            )
          ],
        ),
      ),
    );
  }
}