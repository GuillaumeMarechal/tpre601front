import 'package:arosaje/ui/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:arosaje/ui/login.dart'; // Importez votre LoginPage

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernamePasswordController = TextEditingController();
  String signupResult = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
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
        child: Container(
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
              if(signupResult != "")
                Text(signupResult),
              if(signupResult != "")
                SizedBox(height: 16.0),
              TextFormField(
                controller: usernamePasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Pseudo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
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
                controller: passwordController,
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
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Confirmation mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  const Text("Vous avez déjà un compte ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Connectez-vous !',
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
                      if (confirmPasswordController.text == passwordController.text) {
                        try {
                          final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          await UserService().register(usernamePasswordController.text);
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            if (e.code == 'weak-password') {
                              signupResult = 'Le mot de passe est trop faible.';
                            } else if (e.code == 'email-already-in-use') {
                              signupResult = 'Ce compte existe déjà pour cet e-mail.';
                            } else {
                              signupResult = e.message ?? "Erreur inconnue";
                            }
                          });
                        }
                      } else {
                        setState(() {
                          signupResult = "Les mots de passe ne correspondent pas";
                        });
                      }
                    },
                    child: Text(
                      'S\'inscrire',
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
      ),
    );
  }
}
