class User{
  final String email;
  final String uid;
  final String username;
  final List followers;
  final List following; 

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.followers,
    required this.following
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'uid': uid,
    'email': email,
    'followers': followers,
    'following': following,
  };
}