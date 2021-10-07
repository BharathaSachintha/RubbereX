import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUs extends StatefulWidget {

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final _key = UniqueKey();
  bool isLoading = true;
  String siteLink =
      "https://bharathasachintha.sitelanka.com/wp/";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text('Exit'),
            content: Text('Do you really want to exit?'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: () => Navigator.pop(c, true),
              ),
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(c, false),
              ),
            ],
          )),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                key: _key,
                initialUrl: siteLink,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Stack(),
            ],
          ),
        ),
      ),
    );
  }
}
