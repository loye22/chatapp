import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            return chatScreen();
          }
          return authScreen();
        },
      ),
      routes: {
        chatScreen.routeName: (ctx) => chatScreen(),
        authScreen.routeName: (ctx) => authScreen()
      },
    );
  }
}
