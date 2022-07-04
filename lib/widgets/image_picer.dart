import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import 'package:image_picker/image_picker.dart';

class imagePicker extends StatefulWidget {
//  const imagePicker({Key? key}) : super(key: key);

  @override
  State<imagePicker> createState() => _imagePickerState();
  final Function(File image) _fun;

  imagePicker(this._fun);
}

class _imagePickerState extends State<imagePicker> {
  File _mfile;

  void _picImage() async {
    var image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
     // imageQuality: 50,
     // maxWidth: 150

    );
    if (image == null) {
      return;
    }
    setState(() {
      //_mfile =image as File;
      _mfile = File(image.path);
    });
    widget._fun(_mfile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
           backgroundImage: _mfile != null ? FileImage(_mfile) : null ,

        ),


        FlatButton.icon(
          onPressed: _picImage,
          icon: Icon(Icons.camera),
          label: Text('Upload images '),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
