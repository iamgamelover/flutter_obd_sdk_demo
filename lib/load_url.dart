import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


class LoadURL extends StatefulWidget {
  @override
  LoadURLState createState() {
    return LoadURLState();
  }
}

class LoadURLState extends State<LoadURL> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help')),
      body: WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets();
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
      ),

      floatingActionButton: jsButton(),

    );
  }

  // function
  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/index.html');
    _controller.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }

  // Widget
  Widget jsButton() {
    return FloatingActionButton(
      onPressed: () async {
        _controller
          .evaluateJavascript('genMnemonic()')
          .then((result) {
            print("==> result = $result");
          });
      },
      child: Text('call JS'),
    );
  }

}