/*import 'package:firebase_auth/firebase_auth.dart' hide PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:type_me/refs/refs.dart';

import 'LoginPage.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseUIAuth.configureProviders([
    PhoneAuthProvider()
    // ... other providers
  ]);
  
  final FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.app});

  final FirebaseApp app;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  late DatabaseReference _peopleRef, _chatListRef;
  late FirebaseDatabase database;

  bool isUserInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = FirebaseDatabase(app:  widget.app);


    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //processLogin(context);
    }//);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(child: Text(widget.app.name),),
    );
  }


  /*void processLogin(BuildContext context) async{
    var user = FirebaseAuth.instance.currentUser;

    if(user == null){
      SignInScreen(
        actions: [
          VerifyPhoneAction((context, _) {
            Navigator.pushNamed(context, '/phone');
          }),
        ],
      );
    } else
      await _checkLoginState(context);
  }

 /* Future<User> _checkLoginState(BuildContext context) async{
    if(FirebaseAuth.instance.currentUser !=null)
      {
        FirebaseAuth.instance.currentUser!
            .getIdToken()
            .then((token) async{
            _peopleRef = database.ref().child(people_ref);
            
            _chatListRef = database
            .ref()
            .child(chatlist_ref)
            .child(FirebaseAuth.instance.currentUser!.uid);

            _peopleRef.child(FirebaseAuth.instance.currentUser!.uid)
            .once()
            .then((snapshot){
              if(snapshot != null && snapshot.value !=null)
            });
        });

        }
      return FirebaseAuth.instance.currentUser;
      }*/*/
  */
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:type_me/Auth.dart';
import 'package:type_me/LoginPage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Auth(),
    );
  }
}
