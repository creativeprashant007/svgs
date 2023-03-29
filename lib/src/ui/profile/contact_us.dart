import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/model/static_content/contact_us_response.dart';
import 'package:svgs_app/model/static_content/static_content_response.dart';
import 'package:svgs_app/providers/static_page_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

class ContactUs extends StatefulWidget {
  static const routeName = '/contact-us';
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  StaticPageProvider _staticPageProvider;
  StaticContentResponse staticContentResponse;
  List<ContactUsAddress> _contactUsAddress = [];

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    Future.delayed(Duration(seconds: 0), () {
      callContactUs();
    });
  }

  callContactUs() async {
    var response = await _staticPageProvider.getContactUs(context);
    if (response is ContactUsResponse) {
      _contactUsAddress = response.result.all_address;
    }
  }

  @override
  Widget build(BuildContext context) {
    _staticPageProvider = Provider.of<StaticPageProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.bg_grey,
        appBar: AppBar(
          title: Text('Contact Us'),
        ),
        body: _staticPageProvider.getLoading()
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.themecolor,
                ),
              )
            : Container(
                color: AppColors.bg_grey,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10.0),
                child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: _contactUsAddress.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Card(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  // width: 300,
                                  color: AppColors.themecolor,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      '${_contactUsAddress[index].address_name}',
                                      style: TextStyles.actionTitleWhite,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    '${_contactUsAddress[index].address}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        MdiIcons.whatsapp,
                                        color: AppColors.actionColorDarkGreen,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '${_contactUsAddress[index].whatsapp_number}',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ));
  }
}
