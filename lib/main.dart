import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swifty companion',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade50),
      ),
      home: const MyHomePage(title: 'Swifty companion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Rechercher...',
            prefixIcon: Icon(Icons.person_search),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.check_rounded),
          ),
        ),
      ),

      body: Center(
        child: Column(

          children: <Widget>[
            const Text('Search for a 42 intra profile information'),
          ],
        ),
      ),
    );
  }
}
