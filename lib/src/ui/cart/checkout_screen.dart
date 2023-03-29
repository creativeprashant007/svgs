import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:flutter/material.dart';
import 'package:svgs_app/widgets/alert/offer_alert.dart';
import '../../../widgets/widget.dart';

class Checkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => check_out();
}

class Item {
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemName, this.itemQun, this.itemPrice});
}

class check_out extends State<Checkout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;

  IconData _backIcon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  List<Item> itemList = <Item>[
    Item(itemName: 'Black Grape', itemQun: 'Qty:1', itemPrice: '\₹ 100'),
    Item(itemName: 'Tomato', itemQun: 'Qty:3', itemPrice: '\₹ 112'),
    Item(itemName: 'Mango', itemQun: 'Qty:2', itemPrice: '\₹ 105'),
    Item(itemName: 'Capsicum', itemQun: 'Qty:1', itemPrice: '\₹ 90'),
    Item(itemName: 'Lemon', itemQun: 'Qty:2', itemPrice: '\₹ 70'),
    Item(itemName: 'Apple', itemQun: 'Qty:1', itemPrice: '\₹ 50'),
  ];
  String toolbarname = 'CheckOut';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final pin_v = Provider.of<AreaBranchProvider>(context).pin_v;
    final area_v = Provider.of<AreaBranchProvider>(context).area_v;

    final double height = MediaQuery.of(context).size.height;

    TabBar tabBar = TabBar(
      labelColor: AppColors.whiteColor,
      unselectedLabelColor: AppColors.new_black_text,
      labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0),
              topLeft: Radius.circular(12.0),
            ),
          ),
          color: AppColors.themecolor),
      tabs: [
        Tab(
          text: 'Home Delivery',
        ),
        Tab(
          text: 'Take Away',
        ),
      ],
    );

    AppBar appBar = AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          _backIcon(),
          color: AppColors.whiteColor,
        ),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                MaterialIcons.location_on,
                color: AppColors.whiteColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Deliver To',
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 14)),
                  Text(
                    area_v.toString() + '-' + pin_v.toString(),
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      bottom: tabBar,
      backgroundColor: AppColors.themecolor,
      // actions: <Widget>[
      //   new Padding(
      //     padding: const EdgeInsets.all(15.0),
      //     child: new Text('Check Out', style: TextStyles.actionTitle_w),
      //   )
      // ],
      actions: [
        OfferAlert(),
      ],
    );

    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        body: TabBarView(
          children: <Widget>[
            HomeDelivery(),
            Takeaway(),
          ],
        ),
      ),
    );
  }

  IconData _add_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.add;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  IconData _sub_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.remove;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
