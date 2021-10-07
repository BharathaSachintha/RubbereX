library home_view;

import 'package:app/Shopping/cartPage/cartPage.dart';
import 'package:app/Shopping/mainController.dart';
import 'package:app/Shopping/product_details/productDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final MainController _mainController = Get.put(MainController());
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.grey,
          icon: Icon(Icons.menu),
          onPressed: () => _key.currentState.openDrawer(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Positioned(
                right: 16,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(_auth.currentUser.uid)
                              .collection("cart")
                              .snapshots(),
                          builder: (context, snapshot) {
                            String x = snapshot.data.size.toString();
                            return Text(
                              "${x}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.w600),
                            );
                          })),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Get.to(CartPage());
                  }),
            ]),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20),
                child: Row(
                  children: [
                    Text(
                      "Top Products",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data.docs;

                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 0.8,
                                  crossAxisCount: 2),
                          itemCount: documents.length,
                          padding: EdgeInsets.all(2.0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                _mainController.tapped_item_image.value =
                                    documents[index]['item_image'];
                                _mainController.tapped_item_name.value =
                                    documents[index]['item_name'];
                                _mainController.tapped_item_price.value =
                                    documents[index]['item_price'];
                                _mainController.tapped_item_id.value =
                                    documents[index]['item_id'];
                                _mainController.tapped_item_description.value =
                                documents[index]['description'];
                                Get.to(ProductDetails());
                              },
                              child: Container(
                                // height: 20,
                                // width: 20,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.deepPurpleAccent
                                            .withOpacity(0.02),
                                        blurRadius: 10.0, // soften the shadow
                                        spreadRadius: 6.0, //extend the shadow
                                        offset: Offset(
                                          0.0, // Move to right 10  horizontally
                                          3.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex: 7,
                                          child: Image(
                                            image: NetworkImage(
                                                documents[index]['item_image']),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            documents[index]['item_name'],
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            'LKR ' +
                                                documents[index]['item_price'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator());
                    }
                  })
              // SingleChildScrollView(
              //   child: Container(
              //     child: Padding(
              //       padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              //       child: Column(
              //         children: [
              //           // _Profile(),
              //           // Text(_auth.currentUser!.uid)
              //           Padding(
              //             padding: const EdgeInsets.only(bottom: 20),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceAround,
              //               children: [
              //                 Container(
              //                   decoration: BoxDecoration(
              //                       color: Colors.grey.shade300,
              //                       borderRadius: BorderRadius.circular(20)),
              //                   width: MediaQuery.of(context).size.width * 0.4,
              //                   height: 200,
              //                 ),
              //                 Container(
              //                   decoration: BoxDecoration(
              //                       color: Colors.grey.shade300,
              //                       borderRadius: BorderRadius.circular(20)),
              //                   width: MediaQuery.of(context).size.width * 0.4,
              //                   height: 200,
              //                 ),
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              ),
          // SizedBox(height: 50),
          // TextField(
          //   controller: textEditingController,
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: 'Type here',
          //   ),
          // ),
          // TextButton(
          //   onPressed: () async {
          //     await FirebaseFirestore.instance
          //         .collection("test")
          //         .add({"data": textEditingController.text.toString()}).then((value) {
          //       print("test is done");
          //     });
          //   },
          //   child: Text("Add"),
          // ),
        ],
      ),
      // drawer: _Drawer(),
    );
  }
}
