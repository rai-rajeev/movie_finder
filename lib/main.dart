


import 'package:flutter/material.dart';

import 'appview/splash.dart';
import'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
bool rememberMe=false;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs=await SharedPreferences.getInstance();
  rememberMe=prefs.getBool("remember_me")?? false;
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector
      (onTap: (){
        FocusScopeNode currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
    },
      child: MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.grey,
        ),


        home:SplashPage(),



      ),
    );
  }
}


