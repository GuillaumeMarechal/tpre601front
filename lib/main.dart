import 'package:arosaje/ui/login.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/forum.dart';
import 'ui/map.dart';
import 'ui/message.dart';
import 'ui/my_plants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // Couleur de fond de l'appbar
          elevation: 0, // Pour enlever l'ombre de l'appbar
          iconTheme: IconThemeData(color: Colors.black), // Couleur des icônes dans l'appbar
          titleTextStyle: TextStyle(color: Colors.black), // Couleur du texte dans l'appbar
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

  @override
  Widget build(BuildContext context) {
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
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: Text(
              'Se connecter',
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
