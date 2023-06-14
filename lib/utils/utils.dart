import 'dart:js';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/login.dart';
import '../screens/signup.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }else{
    return null;
  }
}

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void irLogin(){
    Navigator.of(context as BuildContext).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen()
      ),
    );
  }

  void irRegistro(){
    Navigator.of(context as BuildContext).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignUpScreen()
      ),
    );
  }