

import 'package:find_movies/main.dart';
import 'package:flutter/material.dart';
import 'package:find_movies/appview/homepage.dart';
import 'package:find_movies/authentication/resetpassword.dart';
import 'package:find_movies/authentication/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route='/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller1=TextEditingController();
  final TextEditingController _controller2=TextEditingController();
  bool _hidepassword=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.grey[900] ,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Text('Login',
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
                   color: Colors.grey[600],

                    child: const Image(

                      image:NetworkImage("https://th.bing.com/th/id/OIP.mduxZTgPsbPZnWmDhinjugHaHa?w=180&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7") ,
                      height: 170,
                    )


                  ),
                ),
              ),
              Text("login to continue",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.grey[50]
              ),
              textAlign: TextAlign.center,),
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
                controller: _controller1,
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
                  controller: _controller2,
                  decoration: InputDecoration(
                      hintText: 'Enter your password',
                      filled:true,
                      fillColor: Colors.grey[300],
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _hidepassword=!_hidepassword;
                          }

                          );

                        },
                        icon: Icon(_hidepassword? Icons.visibility:Icons.visibility_off,
                        color: Colors.lightBlue,),
                      ),
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.green,
                    value: rememberMe,
                    side: const BorderSide(
                        color:Colors.grey, ),
                    onChanged: (value){
                      SharedPreferences.getInstance().then(
                          (prefs){
                            prefs.setBool("remember_me", value!);
                          }
                      );
                        setState(() {
                          rememberMe= value!;
                        });


                  },

                  ),
                  const Text('Remember me',

                  style: TextStyle(
                  color: Colors.grey,
                  ),
                  ),
                  const SizedBox(width: 79,),
                  TextButton(
                      onPressed: ()async{
                        final email=await Navigator.push((context),
                            MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
                        if(email!=null){
                          SnackBar Mysnakebar=SnackBar(content: Text('an reset mail has been sent to ${email}'));
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(Mysnakebar);
                        }



                      }
                      , child: const Text('Forgot password',
                    style: TextStyle(
                    color:Colors.red,
                  ),
                  ),

                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: ElevatedButton(

                    onPressed: ()async{
                      String emailAddress=_controller1.text;
                      String password=_controller2.text;
                      try{
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailAddress,
                          password: password,
                        );

                         Navigator.pushReplacement((context),
                             MaterialPageRoute(builder: (context)=>HomePage())).then((value){
                           _controller1.clear;
                           _controller2.clear;
                         });
                      }on FirebaseAuthException catch (e) {

                        showDialog(context: (context),
                            builder:(context){
                          return AlertDialog(

                            content: Text('${e.message}'),
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
                          );});

                      }on FirebaseException catch(e){
                        showDialog(context: (context),
                            builder:(context){
                              return AlertDialog(

                                content: Text('${e.message}'),
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
                              );});


                      }
                      catch(e){
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
                      child: Text('Login',
                      style: TextStyle(
                        fontSize: 25
                      ),),
                    ),
                ),
              ),
              const SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),),
                  TextButton(
                      onPressed: (){
                        Navigator.push((context),
                            MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                      child: Text('Signup',
                        style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[100],
                      ),
                      )
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
