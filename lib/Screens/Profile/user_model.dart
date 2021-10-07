import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelClass {
  final String cart_total;
  final String email;
  final String profile;
  final String uid;
  final String username;

  UserModelClass({
    this.cart_total,
    this.email,
    this.profile,
    this.uid,
    this.username,
  });

  factory UserModelClass.fromDocument(DocumentSnapshot doc) {
    return UserModelClass(
      cart_total: doc['cart_total'],
      email: doc['email'],
      profile: doc['profile'],
      uid: doc['uid'],
      username: doc['username'],
    );
  }
}
