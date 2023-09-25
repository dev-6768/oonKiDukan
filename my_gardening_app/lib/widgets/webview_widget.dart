import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewWidget extends StatefulWidget {
  final WebViewController webController;

  WebviewWidget(this.webController);
  //const WebviewWidget({super.key});

  @override
  State<WebviewWidget> createState() => _WebviewWidgetState(webController);
}

class _WebviewWidgetState extends State<WebviewWidget> {
  final WebViewController webController;
  _WebviewWidgetState(this.webController);
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: webController,
    );
  }
}