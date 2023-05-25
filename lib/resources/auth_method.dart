import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AutenticarRegistro{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //registrar usuario
  Future <String> registroUsuario({
    required String username,
    required String email,
    required String passwd,
  }) async {
    String response = 'Ha ocurrido algún error';
    try{
      if(email.isNotEmpty || passwd.isNotEmpty || username.isNotEmpty){
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: passwd);

        print(cred.user!.uid);
        _firestore.collection('usuarios').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'seguidores': [],
          'siguiendo': [],
        });

        await _firestore.collection('usuarios').add({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'seguidores': [],
          'siguiendo': [],
        });

        response = 'success';
      }
    } catch(error){
      response = error.toString();
    }
    return response;
  }
}