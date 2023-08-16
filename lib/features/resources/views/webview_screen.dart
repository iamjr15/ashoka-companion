import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../widgets/inner_screens_appbar.dart';

class WebViewScreen extends StatefulWidget {
  final String newUrl;
  final String pageTitle;
  const WebViewScreen({Key? key, required this.newUrl, required this.pageTitle}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  late WebViewController controller;

  @override
  void initState() {
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
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.newUrl));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InnerScreensAppBar(
            title: widget.pageTitle,
            onBackTap: () {
              Navigator.pop(context);
            },
            verticalPadding:60.h,
          ),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}