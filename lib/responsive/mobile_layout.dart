import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communitesocial/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:communitesocial/model/user.dart' as model;
import '../providers/user_providers.dart';
import '../utils/global_variables.dart';
import '../utils/utils.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _page = 0;
  late PageController pageController;
  Uint8List? _image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navegarPresionado(int page){
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home, 
              color: _page==0? primaryColor: secondaryColor),
              label: '',
              backgroundColor: primaryColor
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _page==1? primaryColor: secondaryColor),
            label: '',
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble, color: _page==2? primaryColor: secondaryColor),
            label: '',
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: _page==3? primaryColor: secondaryColor),
            label: '',
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _page==4? primaryColor: secondaryColor),
            label: '',
            backgroundColor: primaryColor
          ),
        ],
        onTap: navegarPresionado
      ),
    );
  }
}