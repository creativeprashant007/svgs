import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/cart/checkout_screen.dart';
import 'package:svgs_app/src/logind_signup.dart';
import 'package:svgs_app/src/ui/home/homepage.dart';
import 'package:svgs_app/widgets/alert/offer_alert.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

class FifthPage extends StatefulWidget {
  static const routeName = '/cart';
  final String keyData;

  const FifthPage({
    Key key,
    this.keyData,
  }) : super(key: key);
  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  String toolbarname = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  String pincode;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      refresh_view_cart();
    });
    super.initState();
  }

  // --------------------------------------- SHARIYATH -------------------------------------------
  String success = "";
  String error = "";
  bool _isLoadingQty = false;

  Future<void> refresh_view_cart() async {
    try {
      final uniqueId = Provider.of<ApiProviders>(context, listen: false).uid;
      final userDetails =
          Provider.of<UserDetailsProvider>(context, listen: false).userDetails;
      String memberId;
      if (userDetails.isEmpty) {
        memberId = '';
      } else {
        memberId = Provider.of<UserDetailsProvider>(context, listen: false)
            .userDetails[0]
            .memberId
            .toString()
            .trim();
      }

      print("Checking_auto_load============================view_cart");
      final branchId =
          Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;

      setState(() {
        Provider.of<CartProvider>(context, listen: false)
            .fetchAndSetCartItem(branchId, uniqueId, memberId);
        print("setState============================setState_refresh");
      });
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  } // refresh_view_cart

  Future<void> add_quantity(String cartId, String branch_id, int ind) async {
    try {
      setState(() {
        _isLoadingQty = true;
      });

      // Provider.of<CartProvider>(context)..items[ind].isLoading = true;
      await Provider.of<CartProvider>(context, listen: false)
          .addOneMore(cartId, branch_id);

      print("checking_vera_level============================view_cart");

      final success = Provider.of<CartProvider>(context, listen: false).success;
      final error = Provider.of<CartProvider>(context, listen: false).error;
      print("add_quantity============================view_cart$success");

      if (success == 1) {
        // Fluttertoast.showToast(
        //     msg: "Quantity Added",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: AppColors.themecolor,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        setState(() {
          refresh_view_cart();
        });
      }
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  } // refresh_view_cart

  Future<void> minus_quantity(String cartId, String branch_id, int ind) async {
    try {
      await Provider.of<CartProvider>(context, listen: false)
          .removeOneMore(cartId, branch_id);

      print("checking_vera_level============================view_cart");

      final success = Provider.of<CartProvider>(context, listen: false).success;
      final error = Provider.of<CartProvider>(context, listen: false).error;
      print("add_quantity============================view_cart$success");

      if (success == 1) {
        // Fluttertoast.showToast(
        //     msg: "Quantity Reduced ",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: AppColors.themecolor,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        setState(() {
          refresh_view_cart();
        });
      }
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  } // refresh_view_cart
  // ----------------------------------------------------------------------------------------------------

  Future<void> remove_view_cart(String cart_id, String pro_name) async {
    try {
      setState(() {
        _isLoadingQty = true;
      });

      // Provider.of<CartProvider>(context)..items[ind].isLoading = true;
      await Provider.of<CartProvider>(context, listen: false)
          .removeSingleItem(cart_id);

      print("checking_vera_level============================view_cart");

      final success = await Provider.of<CartProvider>(context, listen: false)
          .success_rmove_cart;
      print("add_quantity============================view_cart$success");

      if (success == 1) {
        Fluttertoast.showToast(
            msg: "Item removed from cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.themecolor,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          refresh_view_cart();
        });
      }
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  } // refresh_view_cart

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(selectedIndex: _selectedIndex)),
          ModalRoute.withName("/src/homepage"));
      /*Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage(selectedIndex:_selectedIndex))
      );*/
    });
  }

  // ================================================================ SHARIYTAH ========================================================
  @override
  Widget build(BuildContext context) {
    String backButton;
    if (widget.keyData == 'back') {
      backButton = '';
    } else {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      backButton = routeArgs['key'];
    }

    print("Checking_auto_load============================get_view_cart_data");

    //for getting cart data
    final cart = Provider.of<CartProvider>(context);
    final cartItem = Provider.of<CartProvider>(context).itemCount;
    toolbarname = 'My Cart (${cartItem})';
    //print(Provider.of<UserDetailsProvider>(context).userDetails[0].id);
    print(toolbarname);

    //print(cart.items[0].productImage);
    // TODO: implement build

    print("setState============================setState_refresh_build_context");

    IconData _add_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_drop_up;
        case TargetPlatform.iOS:
          return Icons.arrow_drop_up;
      }
      assert(false);
      return null;
    }

    IconData _sub_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_drop_down;
        case TargetPlatform.iOS:
          return Icons.arrow_drop_down;
      }
      assert(false);
      return null;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double dd = width * 0.77;
    double hh = height - 110.0;
    int item = 0;
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subtitle1
        .copyWith(color: theme.textTheme.caption.color);

    return new Scaffold(
      bottomNavigationBar: backButton != 'back'
          ? null
          : BottomNavigationBar(
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
                  icon: Icon(MaterialIcons.dashboard),
                  title: Text('Categories'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(MaterialIcons.person_outline),
                  title: Text('Profile'),
                ),
                /* BottomNavigationBarItem(
              icon: Consumer<CartProvider>(
                child: Icon(Icons.shopping_cart),
                builder: (ctx, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString(),
                  color: Colors.purple,
                ),
              ),
              title: Text('Cart'),
            ),*/
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.primaryTextColorGrey,
              unselectedItemColor: AppColors.primaryTextColorGrey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
            ),
      key: _scaffoldKey,
      appBar: AppBar(
        leading: backButton == 'back'
            ? IconButton(
                icon: Icon(
                  _backIcon(),
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : Icon(
                Icons.shopping_cart,
                color: AppColors.whiteColor,
              ),
        title: Text(toolbarname, style: TextStyles.actionTitle_w),
        backgroundColor: AppColors.themecolor,
        actions: [
          OfferAlert(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 10.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // three line description
                              Text(
                                'My Cart : ',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.themecolor,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 2.0),
                              ),
                              // InkWell(
                              //   child: Text(
                              //     '605001',
                              //     style: TextStyle(
                              //         fontSize: 18.0,
                              //         fontWeight: FontWeight.bold,
                              //         decoration: TextDecoration.underline,
                              //         color: Colors.black),
                              //   ),
                              //   onTap: () {},
                              // )
                            ],
                          ),
                        ),
                      ),
                      cart.itemCount >= 1
                          ? Row(
                              children: [
                                Text(
                                  'Clear All',
                                  style: TextStyle(color: AppColors.themecolor),
                                ),
                                Container(
                                  child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _clearAllItem();
                                        // Fluttertoast.showToast(
                                        //     msg: "Cart is cleard",
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.CENTER,
                                        //     timeInSecForIosWeb: 1,
                                        //     backgroundColor: AppColors.themecolor,
                                        //     textColor: Colors.white,
                                        //     fontSize: 16.0);
                                      }),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 12.0, bottom: 10.0),
                  height: hh - 170.0,
                  child: cart.itemCount < 1
                      ? Container(
                          child: Center(
                            child: Text(
                              'No Item in Cart',
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cart.items.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext cont, int ind) {
                            int itemQty = int.parse(cart.items[ind].quantity);
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        right: 0,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            final cartId =
                                                cart.items[ind].cartId;
                                            remove_view_cart(cartId.toString(),
                                                cart.items[ind].productName);
                                          },
                                        )),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 115.0,
                                                  width: dd,
                                                  child: Card(
                                                    elevation: 0.0,
                                                    child: Row(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 110.0,
                                                          width: 95.0,
                                                          child: Image.network(
                                                            '${cart.items[ind].productImage.toString()}',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        SizedBox(
                                                            height: 110.0,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  _verticalD(),
                                                                  Container(
                                                                    width: dd -
                                                                        108.0,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      right:
                                                                          5.0,
                                                                    ),
                                                                    child: Text(
                                                                      '${cart.items[ind].productName}',
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      softWrap:
                                                                          false,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15.0,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                  _verticalD(),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        '\₹ ${cart.items[ind].itemSellPrice}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                            color:
                                                                                Colors.black54),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  cart
                                                                          .items[
                                                                              ind]
                                                                          .isLoading
                                                                      ? Container(
                                                                          margin: const EdgeInsets.only(
                                                                              top:
                                                                                  5),
                                                                          height:
                                                                              20.0,
                                                                          width:
                                                                              20.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                AppColors.themecolor,
                                                                          ))
                                                                      : Container(
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Container(
                                                                                width: 42,
                                                                                height: 35,
                                                                                decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(0.0)),
                                                                                child: IconButton(
                                                                                  icon: Icon(_sub_icon(), color: AppColors.blackColor),
                                                                                  onPressed: () async {
                                                                                    if ((Provider.of<CartProvider>(context, listen: false).items[ind].isLoading)) {
                                                                                      return;
                                                                                    }

                                                                                    if (cart.items[ind].quantity == "1") {
                                                                                      print("Checking_info----------------" + cart.items[ind].quantity);
                                                                                      //cart.removeSingleItem(cart.items[ind].cartId);

                                                                                      notReduceAlert();
                                                                                    } else {
                                                                                      print("minus==============");
                                                                                      cart.items[ind].isLoading = true;
                                                                                      final branchId = Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;
                                                                                      await minus_quantity(cart.items[ind].cartId, branchId, ind);
                                                                                      setState(() {
                                                                                        Provider.of<CartProvider>(context, listen: false).items[ind].isLoading = true;
                                                                                      });
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                margin: EdgeInsets.only(left: 2.0),
                                                                              ),
                                                                              Container(
                                                                                  width: 62,
                                                                                  height: 35,
                                                                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(0.0)),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      '${itemQty}',
                                                                                    ),
                                                                                  )),
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: 2.0),
                                                                              ),
                                                                              Container(
                                                                                width: 42,
                                                                                height: 35,
                                                                                decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(0.0)),
                                                                                child: new IconButton(
                                                                                  icon: Icon(_add_icon(), color: Colors.black),
                                                                                  onPressed: () async {
                                                                                    final branchId = Provider.of<AreaBranchProvider>(
                                                                                      context,
                                                                                      listen: false,
                                                                                    ).branch_id_v;

                                                                                    await add_quantity(cart.items[ind].cartId, branchId, ind);

                                                                                    setState(() {
                                                                                      Provider.of<CartProvider>(
                                                                                        context,
                                                                                        listen: false,
                                                                                      ).items[ind].isLoading = true;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 100.0,
                                                  width: 56.0,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      ' ${(double.parse(cart.items[ind].itemSellPrice) * itemQty).toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
              cart.itemCount < 1
                  ? SizedBox(
                      height: 0,
                    )
                  : Container(
                      margin: const EdgeInsets.all(10.0),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.green,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 12.0,
                                ),
                                Icon(
                                  Icons.info,
                                  color: AppColors.whiteColor,
                                ),
                                Text(
                                  'Total :',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('\₹ ${cart.total}',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      color: AppColors.themecolor,
                                      child: const Text('CONFIRM ORDER'),
                                      textColor: AppColors.whiteColor,
                                      onPressed: () {
                                        if (Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userDetails
                                            .isEmpty) {
                                          Navigator.of(context).pushNamed(
                                              Login_Screen.routeName);
                                        } else {
                                          if (double.parse(cart.total) <
                                              double.parse(
                                                  cart.deliverOverAmount)) {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              duration: Duration(
                                                seconds: 1,
                                              ),
                                              content: Text(
                                                'Minimum order amount is above Rs.100',
                                              ),
                                            ));
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Checkout()));
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )

              /*Expanded(
               )*/
            ],
          ),
        ),
      ),
    );
  }

  verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 07.0, bottom: 0.0),
      );

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('You selected: $value')));
      }
    });
  }

  Future<bool> _clearAllItem() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want clear all product from cart?? '),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () async {
                  String memberId;
                  //   print('we are here');
                  final userDetails = Provider.of<UserDetailsProvider>(
                    context,
                    listen: false,
                  ).userDetails;
                  if (userDetails.isEmpty) {
                    memberId = '';
                  } else {
                    memberId = Provider.of<UserDetailsProvider>(
                      context,
                      listen: false,
                    ).userDetails[0].memberId;
                  }

                  final uniqueId = Provider.of<ApiProviders>(
                    context,
                    listen: false,
                  ).uid;
                  final branchId = Provider.of<AreaBranchProvider>(
                    context,
                    listen: false,
                  ).branch_id_v;
                  await Provider.of<CartProvider>(
                    context,
                    listen: false,
                  ).clearCart(uniqueId, memberId, branchId);
                  Navigator.of(context).pop(false);
                },
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> notReduceAlert() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert!!'),
            content: Text('Minimum Order Value is 1.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Ok'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
