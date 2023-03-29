import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/model/static_content/static_content_response.dart';
import 'package:svgs_app/providers/static_page_provider.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUs extends StatefulWidget {
  static const routeName = '/about-us';
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  StaticPageProvider _staticPageProvider;
  StaticContentResponse staticContentResponse;
  var htmlData = '';

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    Future.delayed(Duration(seconds: 0), () {
      callAboutUs();
    });
  }

  callAboutUs() async {
    var response = await _staticPageProvider.getAboutUs(context);
    if (response is StaticContentResponse) {
      htmlData = response.result.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    _staticPageProvider = Provider.of<StaticPageProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
        ),
        body: _staticPageProvider.getLoading()
            ? Center(
                child: CircularProgressIndicator(
                color: AppColors.themecolor,
              ))
            : SingleChildScrollView(child: Html(data: htmlData)));
  }
}
