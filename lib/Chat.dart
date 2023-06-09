import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget{
  final Map<String, dynamic> userMap;
  final String chatId;

  Chat({required this.chatId, required this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async{
    if (_message.text.isNotEmpty){
    Map<String, dynamic> messages = {
      "sendby": _auth.currentUser!.displayName,
      "message": _message.text,
      "time": FieldValue.serverTimestamp(),
    };

    _message.clear();
    await _firestore.collection('chat').doc(chatId).collection('chats').add(messages);
  }else{
      print("Enter text");
    }
  }
  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection("users").doc(userMap['uid']).snapshots(),
          builder: (context, snapshot){
           if (snapshot.data != null){
             return Container(
               child: Column(
                 children: [
                   Text(userMap['nick']), Text(snapshot.data!['status']),
                 ],
               ),
             );
           }else{
             return Container();
           }
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('chat').doc(chatId).collection('chats').orderBy("time", descending: false).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                   if(snapshot.data != null){
                     return ListView.builder(
                       itemCount: snapshot.data!.docs.length,
                       itemBuilder: (context, index){
                         Map<String, dynamic> map = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                         return messages(size, map);
                       },
                     );
                   }else{
                     return Container();
                   }
                },
              ),
            ),
      Container(
        height: size.height / 10,
        width: size.width,
        alignment: Alignment.center,
        child: Container(
          height: size.height / 12,
          width: size.width / 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height / 17,
                width: size.width / 1.3,
                child: TextField(
                controller: _message,
                  decoration: InputDecoration(
                    hintText: "Send Message",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  ),
                ),
              IconButton(onPressed: onSendMessage, icon: Icon(Icons.send))
            ],
          ),
        ),
      ),
    ],
    ),
    ),
    );
  }
  Widget messages(Size size, Map<String, dynamic> map){
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser!.displayName?Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.pinkAccent
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Text(
          map['message'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        )
    ),
    );
  }
}