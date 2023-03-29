import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/product_details.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/cart/fifth.dart';
import '../widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' show parse;

class Item_Details extends StatefulWidget {
  static const routeName = '/item-details';

  @override
  State<StatefulWidget> createState() => item_details();
}

class item_details extends State<Item_Details> with TickerProviderStateMixin {
//for costum tab bar
  // int _startingTabCount = 0;

  List<Tab> _tabs = List<Tab>();
  List<Widget> _generalWidgets = List<Widget>();
  TabController _tabController;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      //     final routeArgs =
      //     ModalRoute.of(context).settings.arguments as Map<String, String>;
      // toolbarname = routeArgs['product_name'];
      // productSlug = routeArgs['product_slug'];
      //  Provider.of<ProductDetail>(context).fetchAndSetProductDetail(productSlug)
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> getWidgets(
    String productId,
    String productItemId,
    String productName,
    String productImage,
    String productItemsSpec,
    String productItemsUnit,
    String productItemsStock,
    String productItemsOrginalSellprice,
    String productItemsOldPrice,
    String productItemsDiscount,
    int count,
  ) {
    _generalWidgets.clear();
    for (int i = 0; i < count; i++) {
      //print(productName);
      _generalWidgets.add(getWidget(
        productId,
        productItemId.split(',')[i],
        productName,
        productImage.split(',')[i],
        productItemsSpec.split(',')[i],
        productItemsUnit.split(',')[i],
        productItemsStock.split(',')[i],
        productItemsOrginalSellprice.split(',')[i],
        productItemsOldPrice.split(',')[i],
        productItemsDiscount.split(',')[i],
      ));
    }
    return _generalWidgets;
  }

  List<Tab> getTabs(String productUnit, String productSpec,
      String productOringinalSellPrice, int count) {
    _tabs.clear();
    for (int i = 0; i < count; i++) {
      _tabs.add(getTab(
        i,
        productUnit.split(',')[i],
        productSpec.split(',')[i],
        productOringinalSellPrice.split(',')[i],
      ));
    }
    return _tabs;
  }

  TabController getTabController(int length) {
    return TabController(length: length, vsync: this);
  }

  Tab getTab(int index, String unit, String spec, String price) {
    // print(product[0].productItemsPrice.split(',')[index]);
    return Tab(
      child: Text(
        '₹${price} \n${spec} ${unit}',
        // style: TextStyle(
        //   color: AppColors.whiteColor,
        // ),
      ),
    );
  }

  Widget getWidget(
    String productId,
    String itemId,
    String productName,
    String productImage,
    String itemSpec,
    String itemUnit,
    String itemStock,
    String productSalePrice,
    String productOldPrice,
    String productDiscount,
  ) {
    print(productName);
    return ProductDetailTabView(
      itemId: itemId,
      productId: productId,
      productName: productName,
      productImage: productImage,
      itemSpec: itemSpec,
      itemUnit: itemUnit,
      itemStock: itemStock,
      productSalePrice: productSalePrice,
      productOldPrice: productOldPrice,
      productDiscount: productDiscount,
    );
  }

  String toolbarname;
  String productSlug;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List list = ['12', '11'];
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    toolbarname = routeArgs['product_name'];
    productSlug = routeArgs['product_slug'];
    print(productSlug);

    // Provider.of<ProductDetail>(context).product_detail;
    //Provider.of<ProductDetail>(context).fetchAndSetProductDetail(productSlug);

    final items = Provider.of<ProductDetail>(context);
    //_startingTabCount = itemDetails.productItemsUnit.split(',').length;

    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline1.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.bodyText1;
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

    IconData _add_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.add_circle;
        case TargetPlatform.iOS:
          return Icons.add_circle;
      }
      assert(false);
      return null;
    }

    IconData _sub_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.remove_circle;
        case TargetPlatform.iOS:
          return Icons.remove_circle;
      }
      assert(false);
      return null;
    }

    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              _backIcon(),
              color: AppColors.whiteColor,
            ),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              //Provider.of<ProductDetail>(context).product_detail.isEmpty;

              Navigator.pop(context);
            },
          ),
          title: Text(
            toolbarname,
            style: TextStyles.actionTitle_w,
          ),
          backgroundColor: AppColors.themecolor,
          actions: <Widget>[
            Consumer<CartProvider>(
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(FifthPage.routeName,
                      arguments: {'key': 'back'});
                },
              ),
              builder: (ctx, cart, _) => Badge(
                child: _,
                value: cart.itemCount.toString(),
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
        body: items.productSlug != productSlug
            ? Center(
                child: CircularProgressIndicator(
                color: AppColors.themecolor,
              ))
            : Consumer<ProductDetail>(builder: (ctx, itemDetails, child) {
                _tabs = getTabs(
                    itemDetails.productItemsUnit,
                    itemDetails.productItemsSpec,
                    itemDetails.productItemsOrginalSellprice,
                    itemDetails.productItemsDiscount.split(',').length);
                _tabController = getTabController(
                    itemDetails.productItemsDiscount.split(',').length);
                return Container(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 380.0,
                          child: TabBarView(
                            controller: _tabController,
                            children: getWidgets(
                              (itemDetails.productId),
                              itemDetails.productItemId,
                              itemDetails.productName,
                              itemDetails.productImage,
                              itemDetails.productItemsSpec,
                              itemDetails.productItemsUnit,
                              itemDetails.productItemsStock,
                              itemDetails.productItemsOrginalSellprice,
                              itemDetails.productItemsOldPrice,
                              itemDetails.productItemsDiscount,
                              itemDetails.productItemsDiscount
                                  .split(',')
                                  .length,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.themecolor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          height: 35,
                          child: TabBar(
                            unselectedLabelColor: AppColors.whiteColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.green,
                                  Colors.green,
                                ]),
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.redAccent),
                            tabs: _tabs,
                            controller: _tabController,
                            labelColor: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Card(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 10.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                    width: double.infinity,
                                    child: Text('Product Description:',
                                        style: TextStyles.txt_16_black_bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _parseHtmlString(
                                      itemDetails.productDescription),
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: AppColors.blackColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
  }
}

class ProductDetailTabView extends StatefulWidget {
  const ProductDetailTabView({
    Key key,
    this.itemId,
    this.productName,
    this.productImage,
    this.itemSpec,
    this.itemUnit,
    this.itemStock,
    this.productSalePrice,
    this.productOldPrice,
    this.productDiscount,
    this.productId,
  }) : super(key: key);
  final String productId;
  final String itemId;
  final String productName;
  final String productImage;
  final String itemSpec;
  final String itemUnit;
  final String itemStock;
  final String productSalePrice;
  final String productOldPrice;
  final String productDiscount;

  @override
  _ProductDetailTabViewState createState() => _ProductDetailTabViewState();
}

class _ProductDetailTabViewState extends State<ProductDetailTabView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

      await Provider.of<CartProvider>(context, listen: false)
          .fetchAndSetCartItem(branchId, uniqueId, memberId);
      setState(() {
        if (Provider.of<CartProvider>(context, listen: false).success == 1) {
          _isLoadingQty = false;
        }

        print("setState============================setState_refresh");
      });
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  // refresh_view_cart
  Future<void> addProduct(
    productId,
    String itemId,
    int qty,
    String uniqueId,
    String mem_id,
    String branch_id,
  ) async {
    setState(() {
      _isLoadingQty = true;
    });
    try {
      await Provider.of<CartProvider>(context, listen: false).addItem(
        productId,
        itemId,
        qty,
        uniqueId,
        mem_id,
        branch_id,
      );
      setState(() {
        // Provider.of<CartProvider>(context,listen: false)..items[ind].isLoading = false;
        refresh_view_cart();
        //_isLoadingQty = false;

        // showInSnackBar(
        //     'You Add   One More Quantity');

        // Provider.of<CartProvider>(context).items[ind].isLoading = false;
      });
    } catch (error) {}
  }

  Future<void> add_quantity(String cartId, String branch_id) async {
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
        setState(() {
          // Provider.of<CartProvider>(context)..items[ind].isLoading = false;
          refresh_view_cart();

          // showInSnackBar(
          //     'You Add   One More Quantity');

          // Provider.of<CartProvider>(context).items[ind].isLoading = false;
        });
      }
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  } // refresh_view_cart

  Future<void> minus_quantity(String cartId, String branch_id) async {
    try {
      // Provider.of<CartProvider>(context)..items[ind].isLoading = true;
      await Provider.of<CartProvider>(context, listen: false)
          .removeOneMore(cartId, branch_id);

      print("checking_vera_level============================view_cart");

      final success = Provider.of<CartProvider>(context, listen: false).success;
      final error = Provider.of<CartProvider>(context, listen: false).error;
      print("add_quantity============================view_cart$success");

      if (success == 1) {
        setState(() {
          // Provider.of<CartProvider>(context)..items[ind].isLoading = false;
          refresh_view_cart();
          //showInSnackBar('You Decrease Qty of to  Cart');

          // Provider.of<CartProvider>(context).items[ind].isLoading = false;
        });
      }
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  } // refresh_view_cart

  // ----------------------------------------------------------------------------------------------------
  Future<void> remove_cart_quantity(String cartId) async {
    try {
      setState(() {
        _isLoadingQty = true;
      });
      // Provider.of<CartProvider>(context)..items[ind].isLoading = true;
      await Provider.of<CartProvider>(context, listen: false)
          .removeSingleItem(cartId);

      print("12checking_vera_level============================view_cart");

      final success =
          Provider.of<CartProvider>(context, listen: false).success_rmove_cart;
      //final error = Provider.of<CartProvider>(context).error;
      print("12add_quantity============================view_cart$success");

      if (success == 1) {
        setState(() {
          // Provider.of<CartProvider>(context)..items[ind].isLoading = false;
          refresh_view_cart();
          //showInSnackBar('You Decrease Qty of to  Cart');

          // Provider.of<CartProvider>(context).items[ind].isLoading = false;
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
  // ================================================================ SHARIYTAH ========================================================

  @override
  Widget build(BuildContext context) {
    int itemQuantity = 0;
    final cart = Provider.of<CartProvider>(
      context,
    );
    String cartId;

    final contain = cart.items.where((item) => item.itemId == widget.itemId);
    if (contain.isNotEmpty) {
      itemQuantity = int.parse(cart.items
          .where((item) => item.itemId == widget.itemId)
          .first
          .quantity);
      cartId = cart.items
          .where((cartItem) => cartItem.itemId == widget.itemId)
          .first
          .cartId;
    }

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

    return Card(
      elevation: 1.0,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // photo and title

            Container(
              height: 260.0,
              child: Center(
                child: Image.network(
                  widget.productImage,
                  fit: BoxFit.fill,

                  // package: destination.assetPackage,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 7.0,
                bottom: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      'YOU SAVE ₹ ${double.parse(widget.productDiscount).toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      widget.productName,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 41.0,
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                '₹ ${(widget.productSalePrice).toString()}'
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 15.0,
                              ),
                              child: Text(
                                '₹ ${widget.productOldPrice.toString()}',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: const Color(0xff000000),
                                    color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      itemQuantity == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  width: 10.0,
                                  height: 35.0,
                                ),
                                _isLoadingQty
                                    ? Container(
                                        margin: EdgeInsets.only(
                                          top: 6.0,
                                          right: 90,
                                        ),
                                        height: 20.0,
                                        width: 20.0,
                                        child: CircularProgressIndicator())
                                    : Container(
                                        margin: EdgeInsets.only(
                                          right: 20.0,
                                        ),
                                        width: 150.0,
                                        height: 41.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: AppColors.themecolor,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            if (cart.items
                                                .where((item) =>
                                                    item.productId ==
                                                    widget.productId)
                                                .isEmpty) {
                                              print('false');
                                            } else {
                                              print('true');
                                            }
                                            Provider.of<AreaBranchProvider>(
                                                    context,
                                                    listen: false)
                                                .fetchAreaDetails();
                                            String memberId;
                                            if (Provider.of<
                                                        UserDetailsProvider>(
                                                    context,
                                                    listen: false)
                                                .userDetails
                                                .isEmpty) {
                                              memberId = '';
                                            } else {
                                              memberId = Provider.of<
                                                          UserDetailsProvider>(
                                                      context,
                                                      listen: false)
                                                  .userDetails[0]
                                                  .memberId;
                                            }

                                            print(memberId);
                                            String uniqueId =
                                                Provider.of<ApiProviders>(
                                                        context,
                                                        listen: false)
                                                    .uid;

                                            print(memberId);
                                            final branchId =
                                                Provider.of<AreaBranchProvider>(
                                                        context,
                                                        listen: false)
                                                    .branch_id_v;
                                            print(
                                                'this is branch id ${branchId}');

                                            print(uniqueId);
                                            addProduct(
                                              widget.productId,
                                              widget.itemId,
                                              1,
                                              uniqueId,
                                              memberId,
                                              branchId,
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Add To Cart',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  width: 10.0,
                                  height: 41.0,
                                ),
                                cart.items
                                        .where((cartItem) =>
                                            cartItem.productId ==
                                            widget.productId)
                                        .first
                                        .isLoading
                                    ? Container(
                                        margin: EdgeInsets.only(
                                          right: 80.0,
                                        ),
                                        width: 20.0,
                                        height: 20.0,
                                        child: Center(
                                            child: CircularProgressIndicator()))
                                    : Container(
                                        margin: EdgeInsets.only(
                                          right: 20.0,
                                        ),
                                        width: 150.0,
                                        height: 41.0,
                                        /*  decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(9.0)),*/
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 42,
                                              height: 41,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0)),
                                              child: IconButton(
                                                icon: Icon(_sub_icon(),
                                                    color: Colors.black),
                                                onPressed: () {
                                                  if (cart.items
                                                          .where((cartItem) =>
                                                              cartItem.itemId ==
                                                              widget.itemId)
                                                          .first
                                                          .quantity ==
                                                      '1') {
                                                    setState(() {
                                                      /*cart.removeSingleItem(
                                                        cartId);*/
                                                      remove_cart_quantity(
                                                          cartId);
                                                    });
                                                  } else {
                                                    cart.items
                                                        .where((cartItem) =>
                                                            cartItem
                                                                .productId ==
                                                            widget.productId)
                                                        .first
                                                        .isLoading = true;
                                                    print(cart.items
                                                        .where((cartItem) =>
                                                            cartItem
                                                                .productId ==
                                                            widget.productId)
                                                        .first
                                                        .isLoading);

                                                    final branchId = Provider
                                                            .of<AreaBranchProvider>(
                                                                context,
                                                                listen: false)
                                                        .branch_id_v;

                                                    minus_quantity(
                                                        cartId, branchId);

                                                    setState(() {
                                                      cart.items
                                                          .where((cartItem) =>
                                                              cartItem
                                                                  .productId ==
                                                              widget.productId)
                                                          .first
                                                          .isLoading = true;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 2.0),
                                            ),
                                            Container(
                                                width: 62,
                                                height: 41,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0)),
                                                child: Center(
                                                  child: Text(
                                                    '${itemQuantity}',
                                                    /*     style: descriptionStyle.copyWith(
                                                           fontSize: 20.0,
                                                           color: Colors.black87),*/
                                                  ),
                                                )),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 2.0),
                                            ),
                                            Container(
                                              width: 42,
                                              height: 41,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0)),
                                              child: new IconButton(
                                                icon: Icon(_add_icon(),
                                                    color: Colors.black),
                                                onPressed: () {
                                                  print(cart.items
                                                      .where((cartItem) =>
                                                          cartItem.productId ==
                                                          widget.productId)
                                                      .first
                                                      .isLoading);

                                                  cart.items
                                                      .where((cartItem) =>
                                                          cartItem.productId ==
                                                          widget.productId)
                                                      .first
                                                      .isLoading = true;
                                                  print(
                                                      '=========++++++creative loading+==============');

                                                  print(cart.items
                                                      .where((cartItem) =>
                                                          cartItem.productId ==
                                                          widget.productId)
                                                      .first
                                                      .isLoading);

                                                  final branchId = Provider.of<
                                                              AreaBranchProvider>(
                                                          context,
                                                          listen: false)
                                                      .branch_id_v;

                                                  add_quantity(
                                                      cartId, branchId);

                                                  setState(() {
                                                    cart.items
                                                        .where((cartItem) =>
                                                            cartItem
                                                                .productId ==
                                                            widget.productId)
                                                        .first
                                                        .isLoading = true;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
