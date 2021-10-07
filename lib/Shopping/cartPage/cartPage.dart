import 'package:app/Shopping/creditCard/creditCard.dart';
import 'package:app/Shopping/mainController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CartPage extends StatefulWidget {


  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  MainController _mainController = Get.put(MainController());
  int xx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Cart Details",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser.uid)
                    .collection("cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data.docs;
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SizedBox(
                        // height: 200,
                        child: ListView(
                            children: documents
                                .map((doc) => Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 60,
                                              width: 60,
                                              color: Colors.transparent,
                                              child: Image(
                                                image: NetworkImage(
                                                    doc['item_image']),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    doc['item_name'].toString(),
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              if (int.parse(doc[
                                                                      'item_quantity']) >
                                                                  1) {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "users")
                                                                    .doc(_auth
                                                                        .currentUser
                                                                        .uid)
                                                                    .collection(
                                                                        "cart")
                                                                    .doc(doc.id)
                                                                    .update({
                                                                  "item_quantity":
                                                                      (int.parse(doc['item_quantity']) -
                                                                              1)
                                                                          .toString(),
                                                                  "total_price": (int.parse(doc[
                                                                              'total_price']) -
                                                                          int.parse(
                                                                              doc['item_price']))
                                                                      .toString()
                                                                });
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "users")
                                                                    .doc(_auth
                                                                        .currentUser
                                                                        .uid)
                                                                    .get()
                                                                    .then(
                                                                        (value) async {
                                                                  print("TOTAL PRICE IS " +
                                                                      value['cart_total']
                                                                          .toString());
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "users")
                                                                      .doc(_auth
                                                                          .currentUser
                                                                          .uid)
                                                                      .update({
                                                                    "cart_total": int.parse(value['cart_total']
                                                                            .toString()) -
                                                                        int.parse(_mainController
                                                                            .tapped_item_price
                                                                            .value
                                                                            .toString()),
                                                                  });
                                                                });
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_back_ios,
                                                              size: 20,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: Center(
                                                                child: Text(
                                                              doc['item_quantity'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          InkWell(
                                                              onTap: () async {
                                                                if (int.parse(doc[
                                                                        'item_quantity']) <
                                                                    12) {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "users")
                                                                      .doc(_auth
                                                                          .currentUser
                                                                          .uid)
                                                                      .collection(
                                                                          "cart")
                                                                      .doc(doc
                                                                          .id)
                                                                      .update({
                                                                    "item_quantity":
                                                                        (int.parse(doc['item_quantity']) +
                                                                                1)
                                                                            .toString(),
                                                                    "total_price":
                                                                        (int.parse(doc['total_price']) +
                                                                                int.parse(doc['item_price']))
                                                                            .toString()
                                                                  });
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "users")
                                                                      .doc(_auth
                                                                          .currentUser
                                                                          .uid)
                                                                      .get()
                                                                      .then(
                                                                          (value) async {
                                                                    print("TOTAL PRICE IS " +
                                                                        value['cart_total']
                                                                            .toString());
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "users")
                                                                        .doc(_auth
                                                                            .currentUser
                                                                            .uid)
                                                                        .update({
                                                                      "cart_total": int.parse(value['cart_total']
                                                                              .toString()) +
                                                                          int.parse(_mainController
                                                                              .tapped_item_price
                                                                              .value
                                                                              .toString()),
                                                                    });
                                                                  });
                                                                }
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 20,
                                                              ))
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 60,
                                                      ),
                                                      Text(
                                                        "LKR " +
                                                            doc['total_price']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ),
                    );
                  } else if (!snapshot.hasError) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("error is running....");
                  }
                  return Text("aaaaaaaaaaaaaa");
                }),
          ),
          InkWell(
            onTap: (){
              Get.to(CreditCard());
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                  child: StreamBuilder<QuerySnapshot<Object>>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(_auth.currentUser.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int total = 0;
          
                          snapshot.data.docs.forEach((e) {
                            total =
                                total + int.parse(e['total_price'].toString());
                            _mainController.totalPay.value = total;
                          });
          
                          return Text(
                            'Pay Now (LKR ${total})',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          );
                        }
                        return Text("No Action");
                      })),
            ),
          )
        ],
      ),
    );
  }
}
