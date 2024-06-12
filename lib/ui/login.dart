import 'package:arosaje/util/globals.dart';
import 'package:flutter/material.dart';
import 'package:arosaje/ui/register.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'lib/assets/arosaje.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Color(0xFFA2C48B).withOpacity(0.4),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text("Vous n'êtes pas inscrit ? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text(
                          'Inscrivez-vous !',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFA2C48B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Se connecter',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Color(0xFFA2C48B).withOpacity(0.4),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Globals.userId = 1;
                        Globals.botanist = false;
                      },
                      child: const Text("User 1")
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Globals.userId = 2;
                        Globals.botanist = false;
                      },
                      child: const Text("User 2")
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Globals.userId = 3;
                        Globals.botanist = true;
                      },
                      child: const Text("Botaniste")
                  ),
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}
