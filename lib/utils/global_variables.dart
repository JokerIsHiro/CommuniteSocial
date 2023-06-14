
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/add_post_screen.dart';


const webSize = 600;

List<Widget> homeScreenItems = [
    Text("Inicio"),
    Text("buscar"),
    Text("chats"),
    const AddPostScreen(),
];