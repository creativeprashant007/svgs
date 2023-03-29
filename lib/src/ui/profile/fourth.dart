import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/IDClass.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/helpers/db_user_details.dart';
import 'package:svgs_app/main.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/top_deal.dart';
import 'package:svgs_app/providers/user_details_provider.dart';

import 'package:svgs_app/src/logind_signup.dart';
import 'package:svgs_app/src/signup_screen.dart';
import 'package:svgs_app/src/ui/profile/privacy_policy.dart';
import 'package:svgs_app/src/ui/profile/profile_page.dart';
import 'package:svgs_app/src/ui/profile/terms_conditions.dart';

import 'package:svgs_app/widgets/checkout/order_list.dart';
import 'package:svgs_app/widgets/sheet/showpage.dart';

import 'about_us.dart';
import 'contact_us.dart';
import 'delivery_addresses.dart';
import '../../../widgets/cap.dart';

class FourthPage extends StatefulWidget {
  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  void initState() {
    // Future.delayed(Duration.zero).then((value) {
    //   if (Provider.of<UserDetailsProvider>(context).userDetails.isEmpty) {
    //     Navigator.of(context).pushNamed(Login_Screen.routeName);
    //   }
    // });
    super.initState();
  }

  // var areaName = '';
  // var areaPin = '';
  String header_pin_code = "";
  String sub_area_name = "  ";

  void sheet_open() {
    var from_page = "Home";
    showModalBottomSheet(
            enableDrag: false,
            isDismissible: false,
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => new ShowModalPage(from_page: from_page))
        .then((value) {
      setState(() {
        print("000000000000000000000000000000000000000000000000pin_v");

        if (!IDCardClass.pin_v.isEmpty) {
          setState(() {
            header_pin_code = IDCardClass.pin_v;
            sub_area_name = IDCardClass.area_v;
          });

          String branch_id = IDCardClass.branch_id_v;
          Provider.of<TopDealProducts>(context)
              .fetchAndSetTopDealProduct(branch_id);
          print('here need to print.....?????????');
          Provider.of<AreaBranchProvider>(context).fetchAreaDetails();
        } else {
          header_pin_code = "Location";
          sub_area_name = "Select your location";

          final pin_v = Provider.of<AreaBranchProvider>(context).pin_v;

          print(
              "0000000000000000000000000000sssssss00000000000000000000branchid$pin_v");
          print(pin_v);

          if (!pin_v.isEmpty) {
            final area_v = Provider.of<AreaBranchProvider>(context).area_v;
            final branch_id_v =
                Provider.of<AreaBranchProvider>(context).branch_id_v;

            print(
                "0000000000000000000000000000sssssss00000000000000000000branchid$branch_id_v");

            setState(() {
              header_pin_code = pin_v;
              sub_area_name = area_v;

              IDCardClass.pin_v = header_pin_code;
              IDCardClass.area_v = sub_area_name;

              Provider.of<TopDealProducts>(context)
                  .fetchAndSetTopDealProduct(branch_id_v);
              Provider.of<AreaBranchProvider>(context).fetchAreaDetails();
            });
          }
        }
      }); //
      // state
    });
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('LOGOUT'),
            content: Text('Do you want to logout ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context, rootNavigator: true).pop();
                  //Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  DBHelper.deleteUser();
                  Navigator.of(context, rootNavigator: true).pop();
                  //Navigator.of(context).pop(false);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                      ModalRoute.withName("/main"));
                  setState(() {});
                  //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var member;

    if (Provider.of<UserDetailsProvider>(context).userDetails.isEmpty) {
    } else {
      member = Provider.of<UserDetailsProvider>(context).userDetails[0];
    }
    final pin_v = Provider.of<AreaBranchProvider>(context).pin_v;
    print("pin_v======================================$pin_v");
    print(pin_v);
    header_pin_code = pin_v;

    if (!pin_v.isEmpty) {
      final area_v = Provider.of<AreaBranchProvider>(context).area_v;
      sub_area_name = area_v;
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: Icon(
          Icons.person,
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.themecolor,
        title: Text(
          'Profile',
          style: TextStyles.actionTitle_w,
        ),
        actions: [
          Provider.of<UserDetailsProvider>(context).userDetails.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      print("checking_homepage_dart");
                      print("Material Page Route===========================");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login_Screen()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyles.actionTitle_w,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      print("checking_homepage_dart");
                      print("Material Page Route===========================");
                      if (Provider.of<UserDetailsProvider>(context,
                                  listen: false)
                              .userDetails
                              .length <
                          1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_Screen()));
                      } else {
                        _exitApp(context);
                      }
                    },
                    child: Text(
                      'Logout',
                      style: TextStyles.actionTitle_w,
                    ),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Provider.of<UserDetailsProvider>(context).userDetails.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          Card(
                            color: AppColors.themecolor,
                            child: ListTile(
                              title: Text(
                                '${member.name}'.capitalizeFirstofEach,
                                style: TextStyles.profileTitle,
                              ),
                              subtitle: Row(
                                children: [
                                  Text('${sub_area_name}/${header_pin_code}',
                                      style: TextStyles.actionTitle_w),
                                  FlatButton(
                                    onPressed: () {
                                      sheet_open();
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Change',
                                          style: TextStyles.actionTitle_w,
                                        ),
                                        Icon(
                                          Icons.edit_outlined,
                                          color: AppColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Feather.shopping_bag,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  'My Orders',
                                  style: TextStyles.highlighterTwo,
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(OrderList.routeName);
                                },
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(DeliveryAddresses.routeName);
                                },
                                leading: Icon(
                                  SimpleLineIcons.location_pin,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Delivery Address',
                                  style: TextStyles.highlighterTwo,
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(UserProfile.routeName);
                                },
                                leading: Icon(
                                  FontAwesome.address_book_o,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  'Profile',
                                  style: TextStyles.highlighterTwo,
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                          Divider(color: Colors.black),
                        ],
                      ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(AboutUs.routeName);
                  },
                  title: Text(
                    'About Us',
                    style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(PrivacyPolicy.routeName);
                  },
                  title: Text(
                    'Privacy Policy',
                    style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(TermsCondition.routeName);
                  },
                  title: Text(
                    'Terms And Conditions',
                    style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(ContactUs.routeName);
                  },
                  title: Text(
                    'Contact Us',
                    style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Provider.of<UserDetailsProvider>(context).userDetails.isEmpty
                    ? Container()
                    : ListTile(
                        onTap: () {
                          _exitApp(context);
                        },
                        title: Text(
                          'Log Out',
                          style: TextStyles.highlighterTwo,
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
