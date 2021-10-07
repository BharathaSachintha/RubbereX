import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var tapped_item_description=''.obs;
  var tapped_item_id = ''.obs;
  var tapped_item_image = ''.obs;
  var tapped_item_name = ''.obs;
  var tapped_item_price = ''.obs;
  var totalPay = 0.obs;
}
