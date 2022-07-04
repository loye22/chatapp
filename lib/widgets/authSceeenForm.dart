import 'package:chat_app_with_firebasee2/widgets/image_picer.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class authScreenForm extends StatefulWidget {
  final Function(
      String email, String pass, String userName,File image , bool log, BuildContext ctx) f;
  final bool _isLoading;

  authScreenForm(this.f, this._isLoading);

  @override
  State<authScreenForm> createState() => _authScreenFormState();
}

class _authScreenFormState extends State<authScreenForm> {
  final _key = GlobalKey<FormState>();

  String _email = '';
  String _userName = '';
  String _passwd = '';
  var _islogIn = true;
  File _myImage;

  void _getImage(File m){
    _myImage = m ;

  }

  void _submit() {
    final v = _key.currentState.validate();
    if(_myImage == null && !_islogIn){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('plz upload photo'))) ;
      return;
    }
    if (v) {
      _key.currentState.save();
      FocusScope.of(context).unfocus();
      widget.f(_email, _passwd , _userName,_myImage ,_islogIn, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_islogIn)
                    imagePicker(_getImage),
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (v) {
                        if (v.isEmpty || !v.contains('@')) {
                          return 'plz  enter valied email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(label: Text('email address')),
                      onSaved: (v) {
                        _email = v;
                      },
                    ),
                    if (!_islogIn)
                      TextFormField(
                        key: ValueKey('username'),
                        decoration: InputDecoration(label: Text('user name')),
                        validator: (v) {
                          if (v.isEmpty || v.length < 4) {
                            return 'enter valied user name';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _userName = v;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(label: Text('password')),
                      validator: (v) {
                        if (v.isEmpty || v.length < 6) {
                          return 'enter valed passwd';
                        }
                        return null;
                      },
                      obscureText: true,
                      onSaved: (v) {
                        _passwd = v;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    widget._isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RaisedButton(
                            child: Text(_islogIn ? 'log in ' : 'singup'),
                            onPressed: _submit,
                          ),
                    if (!widget._isLoading)
                      FlatButton(
                        child: Text(_islogIn
                            ? 'create new account '
                            : 'already have accounnt'),
                        onPressed: () {
                          setState(() {
                            _islogIn = !_islogIn;
                          });
                        },
                        textColor: Theme.of(context).primaryColor,
                      )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
