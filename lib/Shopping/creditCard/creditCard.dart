import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CreditCard extends StatefulWidget {


  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Text(
          "Payment Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://www.skrill.com/fileadmin/Personal/skrill-visa/visa-hero.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey[900],
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIconConstraints:
                          BoxConstraints(minHeight: 24, minWidth: 24),
                      hintText: 'Card Type',
                      hintStyle: TextStyle(color: Colors.black38),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 30.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey[900],
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIconConstraints:
                          BoxConstraints(minHeight: 24, minWidth: 24),
                      hintText: 'Card Number',
                      hintStyle: TextStyle(color: Colors.black38),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 30.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          cursorColor: Colors.grey[900],
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 24, minWidth: 24),
                            hintText: 'Expire',
                            hintStyle: TextStyle(color: Colors.black38),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 30.0),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          cursorColor: Colors.grey[900],
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 24, minWidth: 24),
                            hintText: 'CVC',
                            hintStyle: TextStyle(color: Colors.black38),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey[900],
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIconConstraints:
                          BoxConstraints(minHeight: 24, minWidth: 24),
                      hintText: 'Shipping Address',
                      hintStyle: TextStyle(color: Colors.black38),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 30.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey[900],
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIconConstraints:
                          BoxConstraints(minHeight: 24, minWidth: 24),
                      hintText: 'Contact Number',
                      hintStyle: TextStyle(color: Colors.black38),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 30.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.black,
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    // ignore: deprecated_member_use
                    child: TextButton(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(15)),
                      // color: Colors.transparent,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(_auth.currentUser.uid)
                            .collection('cart')
                            .get()
                            .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            doc.reference.delete();
                          });
                        });
                        Get.to(PaymentDone());
                      },
                    ),
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
