import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email;
  final String uid;
  final String username;
  final String photoUrl;
  final List followers;
  final List following; 

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.photoUrl,
    required this.followers,
    required this.following
});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'uid': uid,
    'email': email,
    "photoUrl": photoUrl,
    'followers': followers,
    'following': following,
  };
}