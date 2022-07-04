import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newMeasge extends StatefulWidget {
  @override
  State<newMeasge> createState() => _newMeasgeState();
}

class _newMeasgeState extends State<newMeasge> {
  var _txt = '';
  var con = TextEditingController();
  void _sendMsg()async {
    FocusScope.of(context).unfocus();
    final user =await FirebaseAuth.instance.currentUser;
    final userName = await FirebaseFirestore.instance
        .collection('users').doc(user.uid).get();
    print(userName['userName']);

    await FirebaseFirestore.instance.collection('chatss').add({
      'text': _txt.trim(),
      'date' : DateTime.now(),
      'userId':user.uid,
      'userName':userName['userName'],
      'userImage':userName['url']
    });
    con.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor) ,borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: TextField(
                  controller: con,
              decoration: InputDecoration(label: Text('enter ur msg')),
              onChanged: (v) {
                setState(() {
                  _txt = v;
                });
              },
            )),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _txt.trim().isEmpty ? null : _sendMsg,
             )
          ],
        ),
      ),
    );
  }
}
