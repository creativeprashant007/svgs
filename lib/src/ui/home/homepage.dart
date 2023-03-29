import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:svgs_app/constants/IDClass.dart';
import 'package:svgs_app/firebase/push_notification_service_helper.dart';
import 'package:svgs_app/helpers/db_user_details.dart';
import 'package:svgs_app/networking/api_provider.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:svgs_app/model/pincode_model.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/banner_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/categories.dart';
import 'package:svgs_app/providers/common_provider.dart';
import 'package:svgs_app/providers/product_cart_provider.dart';
import 'package:svgs_app/providers/shop_categories_provider.dart';
import 'package:svgs_app/providers/top_deal.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/cart/fifth.dart';
import 'package:svgs_app/src/ui/profile/fourth.dart';
import 'package:svgs_app/src/ui/search/second.dart';
import 'package:svgs_app/src/ui/categories/third.dart';

import 'package:svgs_app/widgets/badge_theme.dart';
import 'package:svgs_app/widgets/sheet/showpage.dart';
import 'package:svgs_app/widgets/widgets.dart';
import 'dart:async';
import 'package:svgs_app/bloc/pincode_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';

import '../../../main.dart';
import 'first.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  int selectedIndex;

  HomePage({
    Key key,
    this.selectedIndex = 0,
  }) : super(key: key); // Test 3dfdfgdfgdfg

  @override
  _HomePageState createState() => _HomePageState(selectedIndex);
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String userMemberId = '';
  String userUniqueId = '';
  String userBranchId = '';
  int _selectedIndex = 0;
  ProductCartProvider _productCartProvider;
  _HomePageState(int selectedIndex);

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;
  final myController_search_loc = TextEditingController();
  final _textFocus = new FocusNode();

  List data = [];
  List data_area_pin = [];

  String header_pin_code = "";
  String sub_area_name = "Select your location";
  String str_common = "Login";
  bool login_pro = false;

  static List<Widget> _widgetOptions = <Widget>[
    FirstPage(),
    SecondPage(data: 'notback'),
    ThirdPage(),
    FourthPage(),
    FifthPage(keyData: 'back'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = widget.selectedIndex;
      _selectedIndex = index;
    });
  }

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();

    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex;
      print("selectedIndex=======eeeeee==========$_selectedIndex");
    } else {
      print("selectedIndex=======eeeeee==========");
      print(widget.selectedIndex);
    }

    Future.delayed(Duration.zero).then((value) {
      login_pro = false;
      //Provider.of<ApiProviders>(context).uniqueIdApi();
      Provider.of<AreaBranchProvider>(context, listen: false)
          .fetchAreaDetails();
      Provider.of<UserDetailsProvider>(context, listen: false)
          .fetchUserDetails();

      Provider.of<CategoriesProvider>(context, listen: false)
          .fetchAndSetCategories();
      Provider.of<ShopCategoriesProvider>(context, listen: false)
          .fetchAndSetShopCategories();
      Provider.of<BannerProvider>(context, listen: false).fetchAndBanners();
      Provider.of<BannerProvider>(context, listen: false).fetchOffers();
      Provider.of<CommonProvider>(context, listen: false).fetchAndSetCommon();

      print(
          "login_login===========================================================");
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      callCart();
      final uniqueId = Provider.of<ApiProviders>(context, listen: false).uid;
      print("uniqueId_home_page===============================$uniqueId");

      final user_details =
          Provider.of<UserDetailsProvider>(context, listen: false).userDetails;
      print(
          "user_details========================================================$user_details");
      if (!user_details.isEmpty) {
        print("pppppppppppppppppppppppppppppppppppppppppp");
        setState(() {
          login_pro = true;
          str_common = 'Logout';
        });
      } else {
        setState(() {
          login_pro = true;
          str_common = "Login";
        });

        print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
      }

      final branchId =
          Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;

      final pin_v =
          Provider.of<AreaBranchProvider>(context, listen: false).pin_v;
      print("pin_v======================================$pin_v");
      print(pin_v);

      if (!pin_v.isEmpty) {
        final area_v =
            Provider.of<AreaBranchProvider>(context, listen: false).area_v;
        final branch_id_v =
            Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;

        setState(() {
          header_pin_code = pin_v;
          sub_area_name = area_v;

          IDCardClass.pin_v = header_pin_code;
          IDCardClass.area_v = sub_area_name;
        });

        Provider.of<TopDealProducts>(context, listen: false)
            .fetchAndSetTopDealProduct(branch_id_v);

        userUniqueId = Provider.of<ApiProviders>(context, listen: false).uid;
        userBranchId =
            Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;
        userMemberId = Provider.of<UserDetailsProvider>(context, listen: false)
            .userDetails[0]
            .memberId;

        callCart();
      } else {
        Provider.of<TopDealProducts>(context, listen: false)
            .fetchAndSetTopDealProduct(branchId);
        sheet_open();
      }
    });
  }

  updateCart() async {
    _productCartProvider.controller.stream.listen((data) {
      if (data != null) {
        callCart();
      }
    });
  }

  Future<void> callCart() async {
    setState(() {
      Provider.of<CartProvider>(context, listen: false)
          .fetchAndSetCartItem(userBranchId, userUniqueId, userMemberId);
    });
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
          Provider.of<TopDealProducts>(context)
              .fetchAndSetTopDealProduct(branch_id);
          print('here need to print.....?????????');
          Provider.of<AreaBranchProvider>(context).fetchAreaDetails();

          final uniqueId = Provider.of<ApiProviders>(context).uid;
          print("uniqueId_home_page===============================$uniqueId");
          final user_details =
              Provider.of<UserDetailsProvider>(context).userDetails;
          if (!user_details.isEmpty) {
            String memberId = user_details[0].memberId.toString().trim();
            Provider.of<CartProvider>(context)
                .fetchAndSetCartItem(branch_id, uniqueId, memberId);
          } else {
            String memberId = "";
            Provider.of<CartProvider>(context)
                .fetchAndSetCartItem(branch_id, uniqueId, memberId);
          }
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

  @override
  void dispose() {
    myController_search_loc.dispose();
    bloc.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert!!'),
            content: Text('Do you really want to exit ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    _productCartProvider = Provider.of<ProductCartProvider>(context);
    // sheet_open();
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer:
              AppDrawer(subAreaName: sub_area_name, pinCode: header_pin_code),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.whiteColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(MaterialIcons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MaterialIcons.search),
                title: Text('Search'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.viewDashboard),
                title: Text('Categories'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MaterialIcons.person_outline),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Consumer<CartProvider>(
                  child: Icon(Icons.shopping_cart),
                  builder: (ctx, cart, ch) => BadgeTheme(
                    child: ch,
                    value: cart.itemCount.toString(),
                    color: AppColors.themecolor,
                  ),
                ),
                title: Text('Cart'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.themecolor,
            unselectedItemColor: AppColors.primaryTextColorGrey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
          body: SafeArea(
            child: _selectedIndex == 1 ||
                    _selectedIndex == 2 ||
                    _selectedIndex == 3 ||
                    _selectedIndex == 4
                ? Container(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  )
                : Container(
                    child: Column(
                      children: <Widget>[
                        AppBar(
                          leadingWidth: 40,
                          backgroundColor: AppColors.themecolor,
                          leading: Builder(
                            builder: (context) => IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer()),
                          ),
                          title: Row(
                            children: [
                              Text(
                                '${sub_area_name}, ',
                                textAlign: TextAlign.left,
                                style: TextStyles.subText_w,
                              ),
                              Text(
                                header_pin_code,
                                textAlign: TextAlign.left,
                                style: TextStyles.subText_w,
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              InkWell(
                                onTap: () {
                                  sheet_open();
                                },
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.whiteColor,
                                  size: 16.0,
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: InkWell(
                                  onTap: () async {
                                    await canLaunch(ApiProvider().quickBuy)
                                        ? await launch(ApiProvider().quickBuy)
                                        : throw 'Could not launch $ApiProvider().quickBuy';
                                  },
                                  child: Text(
                                    'Quick Buy',
                                    style: TextStyles.subText_w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          color: AppColors.themecolor,
                          padding: EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            bottom: 5.0,
                            top: 0.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 5.0,
                              left: 5.0,
                              right: 5.0,
                            ),
                            child: SearchBar('Search 25000+ Products'),
                          ),
                        ),

                        SizedBox(height: 6.0),
                        // Divider(),

                        _widgetOptions.elementAt(_selectedIndex),
                        //_show()
                      ],
                    ),
                  ),
          ),
        ));
  }

  Future<bool> _exitApp(BuildContext context) {
    /* return await showDialog(
        //Your Dialog Code
    ).then((val){
      Navigator.pop(_context);
    });*/
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
                  //Navigator.of(context).pop(true);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  DBHelper.deleteUser();
                  //Navigator.of(context).pop(true);
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                      ModalRoute.withName("/main"));
                  // setState(() {});
                  //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget buildList(AsyncSnapshot<PincodeModel> snapshot) {
    Expanded(
        child: ListView.builder(
      itemCount: snapshot.data.areas.length,
      //separatorBuilder: (_, __) => Divider(height: 0.5),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.location_on),
          title: Text('${snapshot.data.areas[index].area}' +
              " / " +
              '${snapshot.data.areas[index].pincode}'),
          /* subtitle: Text(
                  snapshot.data.areas[index].pincode
              ),*/
          //trailing: Icon(Icons.arrow_forward_ios),
          isThreeLine: false,
        );
      },
    )
        //),
        );
  }

  Widget buildListRefresh(List data) {
    Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView.builder(
          itemCount: data.length != null ? 0 : data.length,
          //separatorBuilder: (_, __) => Divider(height: 0.5),
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.location_on),
              title: Text('${data[index]['area']}'),
              subtitle: Text("pincode"),
              trailing: Icon(Icons.arrow_forward_ios),
              isThreeLine: false,
            );
          },
        ),
      ),
    );
  }
}
