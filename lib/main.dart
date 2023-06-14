import 'package:communitesocial/providers/user_providers.dart';
import 'package:communitesocial/responsive/mobile_layout.dart';
import 'package:communitesocial/responsive/responsive_layout.dart';
import 'package:communitesocial/responsive/web_layout.dart';
import 'package:communitesocial/screens/login.dart';
import 'package:communitesocial/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyAGKmpC9RpEB3vKphtujBjJ0rM-7wXFEEM", 
      appId: "1:378140653779:web:db042718afb0e64f25bc26", 
      messagingSenderId: "378140653779", 
      storageBucket: "communitesocial.appspot.com",
      projectId: "communitesocial"
      ),
    );
  }else{
    await Firebase.initializeApp();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CommuniteSocial',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: secondaryColor
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return const ResponsiveLayout(
                  webScreenLayout: WebLayout(), 
                  mobileScreenLayout: MobileLayout(),
                );
              }else if(snapshot.hasError){
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          }
        ),
      )
    );
  }
}
