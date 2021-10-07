import 'package:app/Screens/Login/login_screen.dart';
import 'package:app/Screens/Signup/components/background.dart';
import 'package:app/Screens/Signup/components/or_divider.dart';
import 'package:app/Screens/Signup/components/social_icon.dart';
import 'package:app/components/already_have_an_account_acheck.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:app/components/rounded_password_field.dart';
import 'package:app/components/toast_messages.dart';
import 'package:app/dashboard/myhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  double circularProgressVal;
  bool isUserCreated = false;
  bool isAnError = false;

  @override
  Widget build(BuildContext context) {

    showAlertDialog(BuildContext context) {
      // show the dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: !isUserCreated
                    ? Center(child: Text("Creating Account"))
                    : Center(child: Text("Account Created")),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isUserCreated)
                      !isAnError
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
                                Text(
                                    "Hi Please wait until we create your account!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0)
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
                                TextButton(
                                  child: Text("Try Again!"),
                                  onPressed: () => Navigator.pop(context),
                                ),
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
                          TextButton(
                              child: Text("Continue"),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                    ModalRoute.withName("/"));
                              })
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
        isUserCreated = false;
        isAnError = true;
        //Navigator.pop(context);
        showAlertDialog(context);
      });
    }

    bool validateUser() {
      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      final regExp = RegExp(pattern);

      if (_usernameController.text.isEmpty &&
          _passwordController.text.isEmpty) {
        ToastMessages().generalToastMessage("Please fill details", context);
      } else if (_usernameController.text.isEmpty) {
        ToastMessages().generalToastMessage("Please enter username", context);
      } else if (_passwordController.text.isEmpty) {
        ToastMessages().generalToastMessage("Please enter password", context);
      } else if (!regExp.hasMatch(_usernameController.text)) {
        ToastMessages()
            .generalToastMessage("Please enter valid email address", context);
      } else if (_passwordController.text.length < 6) {
        ToastMessages().generalToastMessage(
            "Password should be at leat 6 characters", context);
      } else {
        print("Success!");
        return true;
      }
      return false;
    }

    void _authenticateUser() async {

      showAlertDialog(context);

      setState(() {
        isUserCreated = false;
        isAnError = false;
      });

      print(_usernameController.text);
      print(_passwordController.text);

      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: _usernameController.text, password: _passwordController.text);

        if (FirebaseAuth.instance.currentUser.uid != null) {
          print('User Account Authenticated!');

          User user = FirebaseAuth.instance.currentUser;
          String url="https://firebasestorage.googleapis.com/v0/b/rubber-9e334.appspot.com/o/users%2Fdefault_user.png?alt=media&token=1574ee9b-a36c-4db4-8d78-e5eec6a9114e";

          if (!user.emailVerified) {
            await user.sendEmailVerification();
            print('Verification Email Send!');
          }
          try {
            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser.uid.toString())
                .set({
              "cart_total": "0",
              "email": _usernameController.text,
              "profile": url,
              "uid": FirebaseAuth.instance.currentUser.uid.toString(),
              "username": _usernameController.text,
             // 'password': _passwordController.text,
            }).then((value) {
              print("User Added to Firestore success");
              Navigator.pop(context);
              setState(() {
                isUserCreated = true;
                isAnError = false;
                showAlertDialog(context);
              });
            });
          } catch (e) {
            print("Failed to Add User to Firestore!: $e");
            ifAnError();
          }
        } else {
          print('Failed to User Account Authenticated!');
          ifAnError();
        }
      } catch (e) {
        print(e.toString());
        if (e.toString() ==
            "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
          ifAnError();
          ToastMessages().generalToastMessage(
              "The email address is already in use by another account", context);
        } else {
          ifAnError();
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
              "SIGNUP",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.white,
                  fontFamily: "Font1"),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.30,
            ),
            RoundedInputField(
              hintText: "Your Email",
              userInputController: _usernameController,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              userInputController: _passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                if (validateUser()) {
                  _authenticateUser();
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
