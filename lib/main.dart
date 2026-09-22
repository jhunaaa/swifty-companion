import 'package:flutter/material.dart';
import 'package:swifty_companion/utils/api_call.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load(fileName: ".env");
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

  final TextEditingController _searchController = TextEditingController();
  String searchValue = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: TextField(
          controller: _searchController,
          onSubmitted: (value) {
            setState(() {
              searchValue = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Rechercher...',
            prefixIcon: Icon(Icons.person_search),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.check_rounded),
              onPressed:() async {
                final text = _searchController.text.trim();
                errorMessage = await getProfile(text);
                setState(() {
                  searchValue = text;
                });
              },
            )
          ),
        ),
      ),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Search for a 42 intra profile information'),
            Text(errorMessage),
          ],
        ),
      ),
    );
  }
}
