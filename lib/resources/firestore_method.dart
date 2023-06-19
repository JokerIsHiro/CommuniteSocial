import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communitesocial/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../model/post.dart';

class FirestoreMetodos {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> subirPublicacion(String descripcion, Uint8List? file,
      String uid, String username, String profImage) async {
    String response = "Ha ocurrido algun error";

    try {
      String photoUrl = await AlmacenamientoMetodos()
          .subirImagen('posts', file!, true);
      String postId = const Uuid().v1();

      Post post = Post(
        descripcion: descripcion,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      response = "success";
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> darMeGusta(String postId, String uid, List likes) async {
    String res = "Ha ocurrido algún error";
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> publicarComentario(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Ha ocurrido algún error";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comentarios')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Introduzca un texto por favor";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> borrarPublicacion(String postId) async {
    String res = "Ha ocurrido algún error";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> seguirUsuario(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
      await _firestore.collection('usuarios').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('usuarios').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('usuarios').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('usuarios').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('usuarios').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
