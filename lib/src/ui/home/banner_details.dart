import 'package:flutter/material.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

class BannerDetails extends StatefulWidget {
  final String initialLink;

  const BannerDetails({Key key, this.initialLink}) : super(key: key);
  @override
  _BannerDetailsState createState() => _BannerDetailsState();
}

class _BannerDetailsState extends State<BannerDetails> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.themecolor,
        title: Text(
          '${widget.initialLink}',
          style: TextStyles.actionTitle,
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: '${widget.initialLink}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // TODO(iskakaushik): Remove this when collection literals makes it to stable.
          // ignore: prefer_collection_literals
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
