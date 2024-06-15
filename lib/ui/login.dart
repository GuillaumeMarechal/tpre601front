import 'package:arosaje/util/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:arosaje/ui/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  String loginResult = "";

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
      body: Visibility(
        visible: !Globals.logged,
        replacement: Text("Vous étes déjà connecté"),
        child: Center(
            child: Column(
              children: [
                if(loginResult != "")
                  Text(loginResult),
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
                        controller: emailTextController,
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
                        controller: passwordTextController,
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
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailTextController.text,
                                  password: passwordTextController.text,
                                );
                                Navigator.pop(context);
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  if (e.code == 'user-not-found') {
                                    loginResult = 'No user found for that email.';
                                  } else if (e.code == 'wrong-password') {
                                    loginResult = 'Wrong password provided for that user.';
                                  } else {
                                    loginResult = e.code;
                                  }
                                });
                              }
                            },
                            child: const Text(
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
              ],
            )
        ),
      ),
    );
  }
}