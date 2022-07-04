import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../widgets/authSceeenForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class authScreen extends StatefulWidget {
  static const routeName = '/authScreen';

  @override
  State<authScreen> createState() => _authScreenState();
}

class _authScreenState extends State<authScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoding = false;

  void _submit(String email, String pass, String userName, File image, bool log,
      BuildContext ctx) async {
    UserCredential s;
    try {
      setState(() {
        _isLoding = true;
      });
      if (log) {
        s = await _auth.signInWithEmailAndPassword(
            email: email, password: pass);
      } else {
        s = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);
        setState(() {
          _isLoding = false;
        });

        final ref = FirebaseStorage.instance
            .ref()
            .child('user image')
            .child(s.user.uid + '.jpg');
        var x = await ref.putFile(image).whenComplete(()=>null);
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(s.user.uid)
            .set({'userName': userName, 'email': email , 'url' : url.toString()});
      }
    } on PlatformException catch (err) {
      String msg = 'some thing went wrong';
      if (err.message != null) {
        msg = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (e) {
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text('erooooor'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      print('error');
      print(e);
    } finally {
      // setState(() {
      //   _isLoding = false ;
      // });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: authScreenForm(_submit, _isLoding),
    );
  }
}
