import 'package:firebase_auth/firebase_auth.dart';

class Globals{
  static bool botanist = false;
  static bool logged = false;
  static String token = "";
  static String? uid() => FirebaseAuth.instance.currentUser?.uid;
  static String? email() => FirebaseAuth.instance.currentUser?.email;

  static init(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null){
        logged = false;
      } else {
        logged = true;
      }
    });
  }

  static getHeader(){
    return {
      "authorization": 'Bearer $token'
    };
  }

  static getHeaderContentType(){
    return {
      "authorization": 'Bearer $token',
      "content-type" : "application/json"
    };
  }
}