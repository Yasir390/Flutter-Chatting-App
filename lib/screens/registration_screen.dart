import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../components/rounded_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'regitration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
 late String email, password;
 bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                   // textAlign: TextAlign.center,
                   keyboardType: TextInputType.emailAddress,

                    onChanged: (value) {
                      email = value;
                      print(email);
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kTextFormInputDecoration.copyWith(
                      hintText: 'Enter your Email',),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    //textAlign: TextAlign.center,
                    obscureText: true,
                    obscuringCharacter: '*',
                    cursorColor: Colors.red,
                    style: TextStyle(
                        color: Colors.black
                    ),
                    onChanged: (value) {
                      password = value;
                      print(password);
                    },
                    decoration: kTextFormInputDecoration.copyWith(
                        hintText: 'Enter your Password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),


                  RoundedButton(
                    color: Colors.blueAccent,
                    text: Text('Register'),
                    onPressed: () async {
                      setState(() {
                        showSpinner=true;
                      });

                      try {
                        UserCredential newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.trim(),
                          password: password.trim(),
                        );
                        // Check if the registration was successful
                        if (newUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } catch (e) {
                        if (e is FirebaseAuthException) {
                          print('Firebase Auth Exception Code: ${e.code}');
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.code),
                               duration: Duration(seconds: 2),
                              ));

                      }
                        print('Error during registration: $e');
                      }
                      setState(() {
                        showSpinner=false;
                      });
                      },
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}