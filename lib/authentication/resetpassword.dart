import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  static const String  route='/resetpassword';
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _controller5=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor:Colors.grey[900] ,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Text('Reset Password',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.grey[200]
                  ),
                ),
                SizedBox(height: 250,),
                Text('Email Address',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: _controller5,
                  decoration: InputDecoration(
                      hintText: 'Enter your email',
                      filled:true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                SizedBox(height: 50,),



                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ElevatedButton(

                    onPressed: ()async{
                      String emailAddress=_controller5.text;

                      try{
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: emailAddress,

                        );

                        Navigator.pop((context),emailAddress);


                      }on FirebaseAuthException catch (e) {

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
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                      ),
                                        onPressed: (){
                                          Navigator.of(context,rootNavigator: true).pop();
                                        },
                                        child: Text('OK'));
                                  }
                              )
                            ],
                          );
                        });
                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Reset password',
                        style: TextStyle(
                            fontSize: 20
                        ),),
                    ),
                  ),
                ),
                SizedBox(height: 4,),

              ],
            ),
          ),
        )
    );
  }
}
