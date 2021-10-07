import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatBotWebView extends StatefulWidget {

  @override
  _ChatBotWebViewState createState() => _ChatBotWebViewState();
}

class _ChatBotWebViewState extends State<ChatBotWebView> {

  final _key = UniqueKey();
  bool isLoading = true;
  String siteLink =
      "https://console.dialogflow.com/api-client/demo/embedded/f1992324-1250-4f5c-8b2c-e9f4d4ffae78";

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
