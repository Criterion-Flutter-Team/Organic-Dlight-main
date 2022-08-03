/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;

  const WebViewExample({Key? key, this.url}) : super(key: key);
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';





class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  const WebViewPage({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading=true;
  final _key = UniqueKey();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: MyWidget().myAppBar(title: widget.title.toString(), context),
        body:   Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: widget.url.toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        ),
      ),
    );
  }
}

