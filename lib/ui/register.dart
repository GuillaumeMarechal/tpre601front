import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arosaje/ui/login.dart';
import 'package:arosaje/ui/services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  String signupResult = "";
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          Container(
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Color(0xFFA2C48B).withOpacity(0.4),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Inscription',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                if (signupResult.isNotEmpty && showError)
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.red.withOpacity(0.2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            signupResult,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              showError = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                TextFormField(
                  controller: usernameController,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                Container(
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
                        setState(() {
                          showError = false;
                        });
                        if (await UserService().pseudoUsed(usernameController.text)) {
                          setState(() {
                            signupResult = "Le pseudo est déjà utilisé.";
                            showError = true;
                          });
                        } else {
                          bool? utilisationDonnees = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Conditions d'utilisation des données"),
                                content: Container(
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Chers utilisateurs,",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Nous tenons à vous informer que nous collectons certaines informations pour améliorer votre expérience sur notre plateforme. Voici comment nous utilisons ces données :",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "- Pseudonyme : Votre pseudonyme est unique et peut être modifié à tout moment. Il sert à vous reconnaître sur notre site.",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "- Mot de passe : Votre mot de passe est stocké de manière sécurisée sur les serveurs de Google réservés à notre application. Il n’est connu que de vous et est utilisé uniquement lors de la vérification de vos informations d’identification.",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "- Adresse e-mail : Votre adresse e-mail est également stockée de manière sécurisée. Elle est utilisée uniquement pour la connexion et la vérification d’e-mail.",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "- Nom et prénom : Ces informations ne sont pas obligatoires, mais elles peuvent être utiles pour récupérer votre compte en cas de perte de mot de passe. Vous pouvez choisir de les retirer à tout moment.",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "- Adresse approximative : Lorsque vous signalez une plante, nous vous demandons de fournir une zone approximative où la plante se trouve. Cette information est importante pour les botanistes, car elle leur permet de connaître les plantes à proximité.",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Vous pouvez supprimer votre compte à tout moment.",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text("Refuser"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Text("Accepter"),
                                  )
                                ],
                              );
                            },
                          );

                          if (utilisationDonnees == null || !utilisationDonnees) {
                            setState(() {
                              signupResult = "Vous devez accepter l'utilisation des informations pour vous inscrire.";
                              showError = true;
                            });
                          } else {
                            if (confirmPasswordController.text == passwordController.text) {
                              try {
                                final UserCredential userCredential =
                                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                await UserService().register(
                                  userCredential.user!.uid,
                                  usernameController.text,
                                );
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
                                  showError = true;
                                });
                              }
                            } else {
                              setState(() {
                                signupResult = "Les mots de passe ne correspondent pas";
                                showError = true;
                              });
                            }
                          }
                        }
                      } catch (e) {
                        print(e);
                        setState(() {
                          signupResult = "Une erreur s'est produite : $e";
                          showError = true;
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
