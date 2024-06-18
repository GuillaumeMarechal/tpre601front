import 'package:arosaje/ui/login.dart';
import 'package:arosaje/ui/profile.dart';
import 'package:arosaje/ui/services/PlanteService.dart';
import 'package:arosaje/util/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/forum.dart';
import 'ui/map.dart';
import 'ui/messagePage.dart';
import 'ui/my_plants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print(e);
  }
  Globals.init();
  FirebaseAuth.instance
      .idTokenChanges()
      .listen((User? user) async {
    if (user != null) {
      Globals.token = (await user.getIdToken())!;
    }
    else{
      Globals.token = "";
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    MessagePage(),
    MyPlantsPage(),
    ForumPage(),
    MapPage(),
  ];

  void isBotanist() async {
    if (Globals.logged) {
      Globals.botanist = await PlanteService().isBotanist();
    }
  }

  @override
  Widget build(BuildContext context) {
    isBotanist();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'lib/assets/arosaje.png',
              width: 40,
              height: 40,
            ),
          ],
        ),
        actions: [
          if (!Globals.logged)
            TextButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                setState(() {});
              },
              icon: Icon(Icons.account_circle, color: Colors.black),
              label: const Text(
                'Se connecter',
                style: TextStyle(color: Colors.black),
              ),
            ),
          if (Globals.logged)
            TextButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                setState(() {});
              },
              icon: const Icon(Icons.account_circle, color: Colors.black),
              label: const Text(
                'Profil',
                style: TextStyle(color: Colors.black),
              ),
            ),
        ],
      ),
      body: PageStorage(
        bucket: _bucket,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.white),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist, color: Colors.white),
            label: 'Mes plantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum, color: Colors.white),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.white),
            label: 'Carte',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFFA2C48B),
      ),
    );
  }
}
