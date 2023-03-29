import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/IDClass.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/helpers/db_user_details.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/top_deal.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/logind_signup.dart';
import 'package:svgs_app/src/signup_screen.dart';
import 'package:svgs_app/src/ui/home/homepage.dart';
import '../../../widgets/cap.dart';

import 'package:svgs_app/src/ui/search/second.dart';
import 'package:svgs_app/widgets/sheet/showpage.dart';

import '../main.dart';

class SearchBar extends StatelessWidget {
  String hintText;
  SearchBar(this.hintText);

  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.whiteColor,
      ),
      padding: const EdgeInsets.all(0.0),
      height: 50.0,
      child: new Card(
        elevation: 0,
        // shape: RoundedRectangleBorder(
        //     side: BorderSide(
        //       color: Colors.black,
        //     ),
        //     borderRadius: BorderRadius.circular(30.0)),
        color: AppColors.whiteColor,
        child: Theme(
          data: new ThemeData(
            primaryColor: Colors.black,
            primaryColorDark: Colors.red,
          ),
          child: new TextField(
            // showCursor: false,
            //   autofocus: false,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(SecondPage.routeName, arguments: {'back': 'back'});
            },
            controller: controller,
            decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: '$hintText',
              hintStyle: TextStyle(
                  color: AppColors.primaryTextColorGrey, fontSize: 16.0),
              //helperText: 'Required minimum 3 or more characters',
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.grey,
                size: 30.0,
              ),

              /*suffixStyle: const TextStyle(color: Colors.green)*/
            ),
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatefulWidget {
  final String pinCode;
  final String subAreaName;

  const AppDrawer({
    Key key,
    this.pinCode,
    this.subAreaName,
  }) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _selectedIndex = 0;
  String header_pin_code = "";
  String sub_area_name = "";

  @override
  void initState() {
    // TODO: implement initState
    header_pin_code = widget.pinCode;
    sub_area_name = widget.subAreaName;
    super.initState();
  }

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
          Provider.of<TopDealProducts>(
            context,
            listen: false,
          ).fetchAndSetTopDealProduct(branch_id);
          print('here need to print.....?????????');
          Provider.of<AreaBranchProvider>(
            context,
            listen: false,
          ).fetchAreaDetails();

          final uniqueId = Provider.of<ApiProviders>(
            context,
            listen: false,
          ).uid;
          print("uniqueId_home_page===============================$uniqueId");
          final user_details = Provider.of<UserDetailsProvider>(
            context,
            listen: false,
          ).userDetails;
          if (!user_details.isEmpty) {
            String memberId = user_details[0].memberId.toString().trim();
            Provider.of<CartProvider>(
              context,
              listen: false,
            ).fetchAndSetCartItem(branch_id, uniqueId, memberId);
          } else {
            String memberId = "";
            Provider.of<CartProvider>(
              context,
              listen: false,
            ).fetchAndSetCartItem(branch_id, uniqueId, memberId);
          }
        } else {
          header_pin_code = "Location";
          sub_area_name = "Select your location";

          final pin_v = Provider.of<AreaBranchProvider>(
            context,
            listen: false,
          ).pin_v;

          print(
              "0000000000000000000000000000sssssss00000000000000000000branchid$pin_v");
          print(pin_v);

          if (!pin_v.isEmpty) {
            final area_v = Provider.of<AreaBranchProvider>(
              context,
              listen: false,
            ).area_v;
            final branch_id_v = Provider.of<AreaBranchProvider>(
              context,
              listen: false,
            ).branch_id_v;

            print(
                "0000000000000000000000000000sssssss00000000000000000000branchid$branch_id_v");

            setState(() {
              header_pin_code = pin_v;
              sub_area_name = area_v;

              IDCardClass.pin_v = header_pin_code;
              IDCardClass.area_v = sub_area_name;

              Provider.of<TopDealProducts>(
                context,
                listen: false,
              ).fetchAndSetTopDealProduct(branch_id_v);
              Provider.of<AreaBranchProvider>(
                context,
                listen: false,
              ).fetchAreaDetails();
            });
          }
        }
      }); //
      // state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Provider.of<UserDetailsProvider>(context).userDetails.isEmpty
              ? Container(
                  padding: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  height: 100,
                  decoration: BoxDecoration(color: Colors.black54),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ButtonsForDrawer(
                        callback: () {
                          Navigator.of(context)
                              .pushNamed(Login_Screen.routeName);
                        },
                        text: 'Login',
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      _ButtonsForDrawer(
                        callback: () {
                          Navigator.of(context)
                              .pushNamed(Signup_Screen.routeName);
                        },
                        text: 'Sign Up',
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.themecolor),
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: AppColors.whiteColor,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'Hello, ${Provider.of<UserDetailsProvider>(context).userDetails[0].name} '
                          .capitalizeFirstofEach,
                      style: TextStyles.actionTitleWhite,
                    ),
                  ),
                ),

          ///menue items:
          Column(
            children: [
              //location
              _buildTile(
                  isText: true,
                  color: AppColors.grey,
                  leading: MaterialIcons.location_on,
                  text: '${widget.subAreaName}, ${widget.pinCode}',
                  trailing: Icons.edit_outlined,
                  onpress: () {
                    print('we are here');
                    Navigator.of(context).pop();
                    sheet_open();
                  }),

              //home
              _buildTile(
                  color: _selectedIndex == 0
                      ? AppColors.blackColor
                      : AppColors.grey,
                  leading: Icons.home,
                  text: 'Home',
                  onpress: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          selectedIndex: 0,
                        ),
                      ),
                    );
                  }),

              //search
              _buildTile(
                  color: _selectedIndex == 1
                      ? AppColors.blackColor
                      : AppColors.grey,
                  leading: Icons.search,
                  text: 'Search',
                  onpress: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          selectedIndex: 1,
                        ),
                      ),
                    );
                  }),

              //categories
              _buildTile(
                  color: _selectedIndex == 2
                      ? AppColors.blackColor
                      : AppColors.grey,
                  leading: Icons.dashboard,
                  text: 'Categories',
                  onpress: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          selectedIndex: 2,
                        ),
                      ),
                    );
                  }),

              //Profile
              _buildTile(
                  color: _selectedIndex == 3
                      ? AppColors.blackColor
                      : AppColors.grey,
                  leading: Icons.person_outline,
                  text: 'Profile',
                  onpress: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          selectedIndex: 3,
                        ),
                      ),
                    );
                  }),

              //cart
              _buildTile(
                  color: _selectedIndex == 4
                      ? AppColors.blackColor
                      : AppColors.grey,
                  leading: Icons.shopping_cart,
                  text: 'Cart',
                  onpress: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          selectedIndex: 4,
                        ),
                      ),
                    );
                  }),
              //cart
              _buildTile(
                  color: _selectedIndex == 5
                      ? AppColors.blackColor
                      : AppColors.grey,
                  leading: MdiIcons.whatsapp,
                  text: 'Whatsapp Us',
                  onpress: () {
                    setState(() {
                      _selectedIndex = 5;
                    });
                  }),
              Provider.of<UserDetailsProvider>(context).userDetails.isEmpty
                  ? Container()
                  : _buildTile(
                      color: _selectedIndex == 6
                          ? AppColors.blackColor
                          : AppColors.grey,
                      leading: MdiIcons.logout,
                      text: 'Logout',
                      onpress: () {
                        setState(() {
                          _selectedIndex = 6;
                        });
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
                      }),
            ],
          ),
        ],
      ),
    );
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

  Widget _buildTile(
      {bool isIcon = false,
      bool isText = false,
      IconData leading,
      VoidCallback onpress,
      String text,
      IconData trailing = null,
      Color color}) {
    return ListTile(
      minVerticalPadding: 0,
      onTap: onpress,
      leading: Icon(
        leading,
        size: 25,
        color: isIcon ? AppColors.blackColor : color,
      ),
      trailing: Icon(
        trailing,
        size: 25,
        color: isIcon ? AppColors.blackColor : color,
      ),
      title: Text(
        '$text',
        style: TextStyle(
            color: isText ? AppColors.blackColor : color, fontSize: 14),
      ),
    );
  }

  Widget _ButtonsForDrawer({VoidCallback callback, String text}) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: AppColors.whiteColor, width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5)),
      onPressed: callback,
      child: Text(
        '$text',
        style: TextStyles.actionTitle_w,
      ),
    );
  }
}
