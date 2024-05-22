import 'package:flutter/material.dart';
import 'models/home.dart';
import 'models/forum.dart';
import 'models/map.dart';
import 'models/message.dart';
import 'models/plant.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              // Action lorsque le bouton "Se connecter" est pressé
            },
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: Text(
              'Se connecter',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(),
          MessagePage(),
          PlantsPage(),
          ForumPage(),
          MapPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Accueil',
            backgroundColor: Color(0xFFA2C48B),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.black),
            label: 'Messages',
            backgroundColor: Color(0xFFA2C48B),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist, color: Colors.black),
            label: 'Mes plantes',
            backgroundColor: Color(0xFFA2C48B),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum, color: Colors.black),
            label: 'Forum',
            backgroundColor: Color(0xFFA2C48B),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.black),
            label: 'Carte',
            backgroundColor: Color(0xFFA2C48B),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
      ),
    );
  }
}
