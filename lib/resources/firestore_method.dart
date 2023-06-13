import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communitesocial/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../model/post.dart';

class FirestoreMetodos{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> subirPublicacion(
    String descripcion,
    Uint8List file,
    String uid,
    String username,
    String profImage
  ) async{

    String response = "Ha ocurrido algun error";

    try {
      
      String photoUrl = await AlmacenamientoMetodos().subirImagen("publicaciones", file, true);
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
}