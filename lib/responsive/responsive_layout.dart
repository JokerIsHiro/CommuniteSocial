import 'package:communitesocial/providers/user_providers.dart';
import 'package:communitesocial/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget{
  final Widget webLayout;
  final Widget mobileLayout;
  const ResponsiveLayout({Key? key, required this.webLayout, required this.mobileLayout}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async{
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > webSize){
          return widget.webLayout;
        }
        return widget.mobileLayout;
      },
    );
  }
}