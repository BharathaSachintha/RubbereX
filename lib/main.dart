import 'package:app/Screens/Welcome/welcome_screen.dart';
import 'package:app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard/myhome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser;

  _mainPage(){
    if(user == null){
      return WelcomeScreen();
    } else {
      return MyHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: KPrimaryColor,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: _mainPage(),
    );
  }
}