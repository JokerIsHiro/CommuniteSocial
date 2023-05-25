import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:communitesocial/model/user.dart' as model;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AutenticarMetodos{
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

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: []
        );

        await _firestore.collection('usuarios').doc(cred.user!.uid).set(user.toJson(),);

        //await _firestore.collection('usuarios').add(user.toJson(),);

        response = 'success';
      }
    } catch(error){
      response = error.toString();
    }
    return response;
  }

  //iniciar sesion usuario
  Future<String> loginUsuario({
    required String email,
    required String password
  }) async {
    String response = "Ha ocurrido un error";

    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        response = "success";
      }else{
        response="Rellene todos los campos por favor";
      }
    }catch(err){
      response = err.toString();
    }
    return response;
  }
}