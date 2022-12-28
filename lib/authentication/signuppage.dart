import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:find_movies/authentication/loginpage.dart';

import '../appview/homepage.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String  route='/SignUp';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _controller3=TextEditingController();
  final TextEditingController _controller4=TextEditingController();
  bool _hidepassword=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor:Colors.grey[900] ,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text('Signup',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.grey[200]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50
                  ),
                  child: Center(
                    child: Container(
                      child: const Image(
                        image: NetworkImage('https://th.bing.com/th/id/R.755a44ff1400ef61d892ddd437d66e86?rik=%2bvRgw2g1YbujYw&riu=http%3a%2f%2fauctionbyemail.com%2fimages%2fsignup.gif&ehk=5bWb%2fRAzXs3oT8Mu6JTH0apA0mlffU%2bh5ugCFazW5Us%3d&risl=&pid=ImgRaw&r=0'),
                      )
                      ,
                    ),
                  ),
                ),
                Text('And  Enjoy the App',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey[50],
                  fontWeight: FontWeight.bold
                ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50,),
                Text('Email Address',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: _controller3,
                  decoration: InputDecoration(
                      hintText: 'Enter your email',
                      filled:true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                Text('Password',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[200]

                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  obscureText: _hidepassword,
                  controller: _controller4,
                  decoration: InputDecoration(
                      hintText: 'Enter your password',
                      filled:true,
                      fillColor: Colors.grey[300],
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _hidepassword=!_hidepassword;
                          });
                        },
                        icon:Icon(_hidepassword? Icons.visibility:Icons.visibility_off),
                          color: Colors.lightBlue,
                      ),
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                const SizedBox(height: 50,),

                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),

                    onPressed: ()async{
                      String emailAddress=_controller3.text;
                      String password=_controller4.text;
                      RememberMe=true;
                      try{
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailAddress,
                          password: password,
                        );
                        Navigator.pushAndRemoveUntil((context),

                            MaterialPageRoute(builder: (context)=>HomePage()),
                            ModalRoute.withName(LoginScreen.route)).then((value){
                          _controller3.clear;
                          _controller4.clear;
                        });
                      }
                      on FirebaseAuthException catch (e) {

                        showDialog(context: (context),
                            builder:(context){
                              return AlertDialog(
                                //title:  Text('${e.code}'),
                                content: Text('${e.message}'),
                                actions: [
                                  Builder(
                                      builder: (context) {
                                        return ElevatedButton(
                                            onPressed: (){
                                              Navigator.of(context,rootNavigator: true).pop();
                                            },
                                            child: Text('OK'));
                                      }
                                  )
                                ],
                              );});

                      }catch(e){
                        showDialog(context: (context), builder:(context) {
                          return AlertDialog(

                            content: Text('${e}'),
                            actions: [
                              Builder(
                                  builder: (context) {
                                    return ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context,rootNavigator: true).pop();
                                        },
                                        child: const Text('OK'));
                                  }
                              )
                            ],
                          );
                        });
                      }

                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Sign-up',
                        style: TextStyle(
                            fontSize: 25
                        ),),
                    ),
                  ),
                ),
                const SizedBox(height: 4,),

              ],
            ),
          ),
        )
    );
  }
}
