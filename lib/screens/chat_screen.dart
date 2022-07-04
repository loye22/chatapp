import 'package:chat_app_with_firebasee2/widgets/chat/new_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../widgets/chat/messages.dart';

class chatScreen extends StatefulWidget {
  static const String routeName = '/chatScreen';

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   print('init');
  //   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //   // Getting the token makes everything work as expected
  //   _firebaseMessaging
  //       .getToken()
  //       .then((String token) {
  //     assert(token != null);
  //   });
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');
  //
  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification} ' + DateTime.now().toString());
  //     }
  //   });
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: maseeges()), newMeasge()],
        ),
      ),
    );
  }
}
