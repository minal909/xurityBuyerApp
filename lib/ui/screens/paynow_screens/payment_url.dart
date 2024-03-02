import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../routes/router.dart';

class PaymentUrl extends StatefulWidget {
  String paymentUrl;

  PaymentUrl({required this.paymentUrl});

  @override
  State<PaymentUrl> createState() => _PaymentUrlState();
}

class _PaymentUrlState extends State<PaymentUrl> {
  // final flutterWebviewPlugin = new FlutterWebviewPlugin();

  WebViewController controller = WebViewController();
  bool flag = false;
  bool isCompleted = false;
  int counter = 0;
  StreamSubscription? _onDestroy;
  StreamSubscription<String>? _onUrlChanged;
  // late StreamSubscription<WebViewStateChanged> _onStateChanged;

  @override
  void dispose() {
    counter = 0;
    _onDestroy?.cancel();
    _onUrlChanged?.cancel();
    // _onStateChanged.cancel();
    // flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          ///If found below conditions true it will navigate to landing screen
          if (url.contains("login") || url.contains("redirect")) {
            Navigator.pushNamed(context, landing);
          }
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
    controller.loadRequest(Uri.parse(widget.paymentUrl));
    super.initState();
    flag = false;
    isCompleted = false;
    counter = 0;

    // _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {});

    // _onStateChanged =
    //     flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
    //   if (mounted) {}
    // });

    // _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
    //   if (mounted) {
    //     // if (url.contains("login") || url.contains("redirect")) {
    //     //         Navigator.pushNamed(context, landing);
    //     //         flutterWebviewPlugin.close();
    //     // } else

    //   }
    // });
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    // print("paymentUrl: ${widget.paymentUrl}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f21d1),
        title: Text(
          "Pay Now",
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
