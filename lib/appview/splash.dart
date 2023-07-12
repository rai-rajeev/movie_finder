import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authentication/loginpage.dart';
import 'homepage.dart';
import 'main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
             builder: (context) => StreamBuilder(
                 stream:FirebaseAuth.instance.authStateChanges(),
                 builder: (context, snapshot) {
                   return  (snapshot.hasData && RememberMe )?HomePage():LoginScreen();
                 }
             )

      ));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Find what to watch',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Caveat',
                //fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/find_movies_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'Find Movies',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'IBM Plex Serif',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCircularClipper extends CustomClipper<Rect> {
  final double radius;

  CustomCircularClipper(this.radius);

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
