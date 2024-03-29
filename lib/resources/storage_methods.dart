import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class AlmacenamientoMetodos{

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> subirImagen(
    String childname, Uint8List file, bool publicado) async {
      Reference ref =
        _storage.ref().child(childname).child(_auth.currentUser!.uid);
    if(publicado) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}