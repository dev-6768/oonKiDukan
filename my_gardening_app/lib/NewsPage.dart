import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controllers/string_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:my_gardening_app/widgets/widgets.dart';
import 'widgets/webview_widget.dart';

class NewsPageWidget extends StatefulWidget {
  const NewsPageWidget({super.key});

  @override
  State<NewsPageWidget> createState() => _NewsPageWidgetState();
}

class _NewsPageWidgetState extends State<NewsPageWidget> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(newsFetchUrl),
      );
    
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),
      body: WebviewWidget(
        controller,
      )
    );
  }
}