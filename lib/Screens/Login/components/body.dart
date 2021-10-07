import 'package:app/Screens/Signup/signup_screen.dart';
import 'package:app/Screens/Welcome/components/background.dart';
import 'package:app/components/already_have_an_account_acheck.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/components/toast_messages.dart';
import 'package:app/dashboard/myhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isHidden = true;
  bool isUserSigned = false;
  bool isInValidaAccount = false;
  double circularProgressVal;

  @override
  Widget build(BuildContext context) {

    bool validateUser() {
      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      final regExp = RegExp(pattern);

      if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
        ToastMessages().generalToastMessage('Please fill details', context);
      } else if (_emailController.text.isEmpty) {
        ToastMessages().generalToastMessage('Email is empty', context);
      } else if (!regExp.hasMatch(_emailController.text)) {
        ToastMessages().generalToastMessage('Email pattern is wrong', context);
      } else if (_passwordController.text.isEmpty) {
        ToastMessages().generalToastMessage('Password is empty', context);
      } else {
        print('Validation Success!');
        return true;
      }

      return false;
    }

    showAlertDialog(BuildContext context) {
      // show the dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: !isUserSigned
                    ? Center(child: Text("Sign In"))
                    : Center(child: Text("Welcome Back")),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isUserSigned)
                      !isInValidaAccount
                          ? Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          CircularProgressIndicator(
                            value: circularProgressVal,
                            strokeWidth: 6,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text("Signing to your account...",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0)
                                  .copyWith(color: Colors.grey.shade900)),
                        ],
                      )
                          : Container(
                          child: Column(
                            children: [
                              Text("Error!",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 50.0,
                              ),
                             TextButton(onPressed: () {
                               setState(() {
                                 isUserSigned = false;
                                 isInValidaAccount = false;
                                 Navigator.pop(context);
                               });
                             }, child: Text("Try Again!")),
                            ],
                          ))
                    else
                      Container(
                          child: Column(
                            children: [
                              Text("Welcome!",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 50.0,
                              ),
                              Image.asset(
                                'assets/images/welcome.png',
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                              TextButton(onPressed: () => Navigator.pop(context), child: Text("Continue"))
                            ],
                          )),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              );
            },
          );
        },
      );
    }

    void ifAnError() {
      Navigator.pop(context);
      setState(() {
        isUserSigned = false;
        isInValidaAccount = true;
        //Navigator.pop(context);
        showAlertDialog(context);
      });
    }

    void _signInWithEmailAndPassword() async {
      showAlertDialog(context);

      setState(() {
        isUserSigned = false;
        isInValidaAccount = false;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        print(userCredential.user.uid.toString());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(),
          ),
              (route) => false,
        );
        //Navigator.pop(context);
        print('User is signed in!');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ifAnError();
          print('No user found for that email.');
          ToastMessages().generalToastMessage("No user found for that email", context);
        } else if (e.code == 'wrong-password') {
          ifAnError();
          print('Wrong password provided for that user.');
          ToastMessages().generalToastMessage("Wrong password provided!", context);
        } else {
          ToastMessages().generalToastMessage("Something Went Wrong.", context);
          ToastMessages().generalToastMessage(e.toString(), context);
          print(e.toString());
        }
      }
    }

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.white, fontFamily: "Font1"),
            ),
            SizedBox(height: size.height * 0.03),
            Image.network(
              "https://i.ibb.co/Gt8G58f/logo.png",
              height: size.height * 0.30,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              userInputController: _emailController,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              userInputController: _passwordController,
              onChanged: (value) {

              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                if (validateUser()) {
                  _signInWithEmailAndPassword();
                  print("Sign In");
                }
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyHomePage();
                    },
                  ),
                );*/
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

