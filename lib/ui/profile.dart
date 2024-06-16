import 'package:arosaje/ui/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_data.dart';
import '../util/globals.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserData?> user;
  UserService userService = UserService();
  bool modify = false;
  TextEditingController pseudoController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if(Globals.logged){
      user = userService.getUserData();
    }
    else{
      user = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
        visible: Globals.logged,
        replacement: const Text("Vous devez etre connecté pour acceder a votre profile"),
        child: Column(
          children: [
            FutureBuilder(
              future: user,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  UserData data = snapshot.data!;
                  return Center(
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
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Pseudo : ${data.pseudo}"),
                                ),
                                if(modify)
                                  Expanded(
                                      child: TextFormField(
                                        controller: pseudoController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'nouveau pseudo',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      )
                                  ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Nom : ${data.nom}"),
                                ),
                                if(modify)
                                  Expanded(
                                      child: TextFormField(
                                        controller: nomController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'nouveau nom',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      )
                                  ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Prenom : ${data.prenom}"),
                                ),
                                if(modify)
                                  Expanded(
                                      child: TextFormField(
                                        controller: prenomController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'nouveau prenom',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      )
                                  ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Email : ${Globals.email()}"),
                                ),
                                if(modify)
                                  Expanded(
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'nouveau email',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      )
                                  ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Mot de passe : ********"),
                                ),
                                if(modify)
                                  Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await FirebaseAuth.instance.sendPasswordResetEmail(email: Globals.email()!);
                                      showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            content: const Text("Un mail de changement de mot de passe a été envoyé"),
                                            actions: [
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("valider")
                                              )
                                            ],
                                          );
                                        }
                                      );
                                    },
                                    child: Text("Changer de mot de passe"),
                                  )
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            if(!modify)
                              ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      modify = true;
                                    });
                                  },
                                  child: Text("Modifier")
                              ),
                            if(modify)
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          modify = false;
                                        });
                                      },
                                      child: Text("Annuler")
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if(pseudoController.text != "" && await userService.pseudoUsed(pseudoController.text)){
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
                                          UserData userData = UserData(
                                              pseudoController.text,
                                              nomController.text,
                                              prenomController.text
                                          );
                                          await userService.patchUserData(userData);
                                          if(emailController.text != ""){
                                            FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(emailController.text);
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text("Un email de verification a été envoyé à la nouvelle adresse email."),
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
                                          setState(() {
                                            user = userService.getUserData();
                                            modify = false;
                                          });
                                        }
                                      },
                                      child: Text("Valider")
                                  )
                                ],
                              ),
                          ],
                        ),
                      )
                  );
                }
                else if(snapshot.hasError){
                  print(snapshot.error);
                  return const Center(
                    child: Text("Impossible de récupérer les données"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            ElevatedButton(
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
                Globals.logged = false;
                Navigator.pop(context);
              },
              child: Text("Se deconnecter")
            )
          ],
        )
      ),
    );
  }
}
