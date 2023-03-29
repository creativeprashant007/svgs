import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/model/offers/offers_response.dart';
import 'package:svgs_app/providers/offers_provider.dart';

class OfferAlert extends StatefulWidget {
  const OfferAlert({Key key}) : super(key: key);

  @override
  _OfferAlertState createState() => _OfferAlertState();
}

class _OfferAlertState extends State<OfferAlert> {
  OfferProvider _offerProvider;
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget remindButton = TextButton(
      child: Text(""),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 12,
          ),
          decoration: BoxDecoration(color: Colors.purple[400]),
          child: Text(
            "Close",
            style: TextStyle(color: Colors.black),
          )),
      onPressed: () {
        print("here is data");
        Navigator.pop(context);
      },
    );
    Widget launchButton = TextButton(
      child: Text(""),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.themecolor,
          width: 2.0,
        ),
      ),
      //title: Text(""),
      content: Text(
        "${offers[0]}",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        //remindButton,
        Center(child: cancelButton),
        // launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<String> offers = [];
  callOffers(BuildContext ctx) async {
    var response = await _offerProvider.getOffers(ctx);
    if (response is OffersResponse) {
      offers = response.data;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //callOffers();

    Future.delayed(Duration(seconds: 1), () {
      _offerProvider = Provider.of<OfferProvider>(
        context,
        listen: false,
      );

      callOffers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await callOffers(context);
        showAlertDialog(context);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            "Offers",
            style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
