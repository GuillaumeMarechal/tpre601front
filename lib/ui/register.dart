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
  TextEditingController usernameController = TextEditingController();
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
                      try{
                        if(await UserService().pseudoUsed(usernameController.text)){
                          print("b");
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Le pseudo est deja utilisé."),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text("ok")
                                    )
                                  ],
                                );
                              }
                          );
                        }
                        else{
                          print("c");
                          bool? utilisationDonnees = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  // Ce message d'information à ete generé par Bing Copilot
                                  content: Text("Chers utilisateurs,\n\nNous tenons à vous informer que nous collectons certaines informations pour améliorer votre expérience sur notre plateforme. Voici comment nous utilisons ces données :\n\nPseudonyme : Votre pseudonyme est unique et peut être modifié à tout moment. Il sert à vous reconnaitre sur notre site.\nMot de passe : Votre mot de passe est stocké de manière sécurisée sur les serveurs de google réservés à notre application. Il n’est connu que de vous et est utilisé uniquement lors de la vérification de vos informations d’identification.\nAdresse e-mail : Votre adresse e-mail est également stockée de manière sécurisée. Elle est utilisée uniquement pour la connexion et la vérification d’e-mail.\nNom et prénom : Ces informations ne sont pas obligatoires, mais elles peuvent être utiles pour récupérer votre compte en cas de perte de mot de passe. Vous pouvez choisir de les retirer à tout moment.\nAdresse approximative : Lorsque vous signalez une plante, nous vous demandons de fournir une zone approximative où la plante se trouve. Cette information est importante pour les botanistes, car elle leur permet de connaître les plantes à proximité.\nVous pouvez supprimer votre compte a tout moment."),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context, false);
                                        },
                                        child: Text("refuser")
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context, true);
                                        },
                                        child: Text("accepter")
                                    )
                                  ],
                                );
                              }
                          );
                          if(utilisationDonnees == null || !utilisationDonnees){
                            setState(() {
                              signupResult = "Vous devez accepter l'utilisation des informations pour vous inscrire.";
                            });
                          }
                          else{
                            if (confirmPasswordController.text == passwordController.text) {
                              try {
                                final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                await UserService().register(userCredential.user!.uid, usernameController.text);
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
                          }
                        }
                      }
                      catch(e){
                        print(e);
                        setState(() {
                          signupResult = "Une erreur s'est produite : $e";
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
