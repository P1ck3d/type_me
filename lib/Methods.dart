import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:type_me/LoginPage.dart';


Future<User?> createAccount(String nick, String email, String password) async{
  FirebaseAuth _auth = FirebaseAuth.instance;
 FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try{
    User? user = (await _auth.createUserWithEmailAndPassword(email: email, password: password))
        .user;
    if(user != null){
      user.updateProfile(displayName: nick);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "nick": nick,
        "email": email,
        "status": "Unavailable",
        "uid": _auth.currentUser!.uid,
      });
      return user;
    }else{
      print("Account creation failed");
      return user;
    }
  }catch (e){
    print(e);
  return null;
  }
}

Future<User?> logIn(String email, String password) async{
  FirebaseAuth _auth = FirebaseAuth.instance;

  try{
    User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password))
        .user;
    if(user != null){
      return user;
    }else{
      print("Login failed");
      return user;
    }
  }catch (e){
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async{
  FirebaseAuth _auth = FirebaseAuth.instance;

  try{
    await _auth.signOut().then((user) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }catch (e){
    print("Error");
  }
}