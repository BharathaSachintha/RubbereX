import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mainController.dart';


class ProductDetails extends StatefulWidget {
  const ProductDetails();

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final MainController _mainController = Get.put(MainController());
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            //Get.back();
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "More Details",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Image(
                  image: NetworkImage(_mainController.tapped_item_image.value),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "LKR " + _mainController.tapped_item_price.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _mainController.tapped_item_name.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 22),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  _mainController.tapped_item_description.value,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              /*Table(
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Network"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("GSM / CDMA / HSPA / EVDO / LTE / 5G"),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Dimensions"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "164.3 x 74.6 x 8.1 mm (Glass) / 8.6 mm (Leather)"),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("SIM"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Dual SIM (Nano-SIM, dual stand-by)"),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Resolution"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "1440 x 3200 pixels, 20:9 ratio (~515 ppi density)"),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Camera"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("108 MP, f/1.9, 26mm (wide), 1/1.33"),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Battery"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Li-Po 4600 mAh, non-removable"),
                    )
                  ]),
                ],
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.deepPurpleAccent,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  // ignore: deprecated_member_use
                  child: TextButton(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20)),
                    // color: Colors.black,
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(_auth.currentUser?.uid)
                          .collection("cart")
                          .doc(_mainController.tapped_item_id.value.toString())
                          .set({
                        "item_id":
                            _mainController.tapped_item_id.value.toString(),
                        "item_name":
                            _mainController.tapped_item_name.value.toString(),
                        "item_image":
                            _mainController.tapped_item_image.value.toString(),
                        "item_price":
                            _mainController.tapped_item_price.value.toString(),
                        "item_quantity": "1",
                        "total_price":
                            _mainController.tapped_item_price.value.toString(),
                      }).then((value) async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(_auth.currentUser?.uid)
                            .get()
                            .then((value) async {
                          print("TOTAL PRICE IS " +
                              value['cart_total'].toString());
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(_auth.currentUser?.uid)
                              .update({
                            "cart_total":
                                int.parse(value['cart_total'].toString()) +
                                    int.parse(_mainController
                                        .tapped_item_price.value
                                        .toString()),
                          }).then((_){
                            Get.snackbar("Success!", "${_mainController.tapped_item_name.value.toString()} is added to cart successfully. Check your cart.");
                          });
                        });
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
