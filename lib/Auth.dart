import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:type_me/HomePage.dart';
import 'package:type_me/LoginPage.dart';

class Auth extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
  if(_auth.currentUser != null){
return HomePage();
  } else{
    return LoginPage();
  }
}
}
