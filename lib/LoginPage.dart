import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:type_me/CreateAccountPage.dart';
import 'package:type_me/HomePage.dart';

import 'Methods.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading?
      Center(
      child:
      Container(height: size.height / 20,
      width: size.width / 20,
      child: CircularProgressIndicator(),
      ),
      )

          :SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height / 20,),
          Container(
              alignment: Alignment.centerLeft,
              width: size.width / 1,
              child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios))),
              SizedBox(
                height: size.height / 50,
              ),
          Container(
            width: size.width / 1.1,
            child: Text("Welcome",
              style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold),),
          ),

          Container(
            width: size.width /1.2,
            child: Text(
              "Login to continue!",
              style: TextStyle(
                color: CupertinoColors.systemGrey3,
                fontSize: 23,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
              height: size.height / 10
          ),

          Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Email", Icons.mail_outline, _email)
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child:
          Container(
            width: size.width,
            alignment: Alignment.center,
            child: field(size, "Password", Icons.password_sharp, _password),
           ),
          ),

          SizedBox(
            height: size.height / 10,
          ),
          customButton(size),

          SizedBox(
            height: size.height / 8,
          ),
          GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateAccountPage())),
          child: Text(
            "Create Account",
            style: TextStyle(color: Colors.pink,
                fontSize: 18,
                fontWeight: FontWeight.w400),
          )
          )
        ],
      ),
    ),
    );
  }

  Widget customButton(Size size){
    return GestureDetector(
      onTap: (){
        if(_email.text.isNotEmpty && _password.text.isNotEmpty){
          setState(() {
            isLoading = true;
          });

          logIn(_email.text, _password.text).then((user){
            if (user != null) {
              print("Login successfully completed");
              setState(() {
                isLoading = false;
              });
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
            }else{
              print("Login fialed");
              setState(() {
                isLoading = false;
              });
            }
          });
        }else{

        }
      },
      child: Container(
        height: size.height / 10,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.pinkAccent,
        ),
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        )
      ),
    );
  }

  Widget field(Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
    height: size.height / 15,
    width: size.width / 1.1,
    child: TextField(
      controller: cont,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: TextStyle(color: CupertinoColors.systemGrey3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
  ),
  ),
  ),
    );
  }

}