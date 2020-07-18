import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:obd_demo/load_url.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      // home: LoadURL(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          print("==>  = ${message.message}");
        });
  }

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
      ),

      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'file:///android_asset/flutter_assets/assets/index.html',
          javascriptMode: JavascriptMode.unrestricted,

          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },

          javascriptChannels: <JavascriptChannel>[
            _alertJavascriptChannel(context),
          ].toSet(),

          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('js://webview')) {
              // showToast('JS调用了Flutter By navigationDelegate');
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },

          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        );
      }),

      floatingActionButton: jsButton(),
    );
  }

  Widget jsButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (BuildContext context,
          AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              _controller.future.then((controller) {
                controller
                  .evaluateJavascript('genMnemonic()')
                  .then((result) {
                    print("==> result = $result");
                  });
              });
            },
            child: Text('call JS'),
          );
        }
        return Container();
    });
  }
}
