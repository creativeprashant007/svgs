import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/model/static_content/static_content_response.dart';
import 'package:svgs_app/providers/static_page_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  static const routeName = '/privacy-policy';
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  StaticPageProvider _staticPageProvider;
  StaticContentResponse staticContentResponse;
  var htmlData = '';

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    Future.delayed(Duration(seconds: 0), () {
      callPrivacyPolicy();
    });
  }

  callPrivacyPolicy() async {
    var response = await _staticPageProvider.getPrivacyPolicy(context);
    if (response is StaticContentResponse) {
      htmlData = response.result.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    _staticPageProvider = Provider.of<StaticPageProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Privacy Policy'),
        ),
        body: _staticPageProvider.getLoading()
            ? Center(
                child: CircularProgressIndicator(
                color: AppColors.themecolor,
              ))
            : SingleChildScrollView(child: Html(data: htmlData)));
  }
}
