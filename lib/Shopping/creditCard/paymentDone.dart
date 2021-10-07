import 'package:app/Shopping/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class PaymentDone extends StatefulWidget {


  @override
  _PaymentDoneState createState() => _PaymentDoneState();
}

class _PaymentDoneState extends State<PaymentDone> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 110,
              width: 110,
              child: Lottie.asset("assets/payment_done.json"),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Thank you, your transaction is Completed.",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
