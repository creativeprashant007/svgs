import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/model/cart/product_add_to_cart_request.dart';
import 'package:svgs_app/model/cart/product_add_to_cart_response.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/product_cart_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/item_details.dart';
import '../../providers/product_details.dart';

class ProductListing extends StatefulWidget {
  final String productId;
  final String itemId;
  final String productName;
  final String productSlug;
  final String productImage;
  final String productPrice;
  final String productOldPrice;
  final String productSavePrice;
  final String productSpec;
  final String productUnit;

  const ProductListing({
    Key key,
    @required this.itemId,
    @required this.productId,
    @required this.productName,
    @required this.productImage,
    @required this.productPrice,
    @required this.productOldPrice,
    @required this.productSavePrice,
    @required this.productSlug,
    @required this.productSpec,
    @required this.productUnit,
  }) : super(key: key);

  @override
  _ProductListingState createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  ProductCartProvider _productCartProvider;
  ApiProviders _apiProviders;
  UserDetailsProvider _userDetailsProvider;
  AreaBranchProvider _areaBranchProvider;
  String userUniqueId = '';
  String userBranchId = '';
  String userMemberId = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<DropdownMenuItem> _items = List<DropdownMenuItem>();

  int _value = 0;

  List<DropdownMenuItem> getDrowDownItems(
    int count,
    String unit,
    String spec,
  ) {
    _items.clear();
    for (int i = 0; i < count; i++) {
      _items.add(getDrowDownItem(
        i,
        spec.split(',')[i],
        unit.split(',')[i],
      ));
    }
    return _items;
  }

  DropdownMenuItem getDrowDownItem(
    int index,
    String unit,
    String spec,
  ) {
    // print(product[0].productItemsPrice.split(',')[index]);
    return DropdownMenuItem(
      child: Text('${unit} ${spec}'),
      value: index,
    );
  }

  // --------------------------------------- SHARIYATH -------------------------------------------
  String success = "";
  String error = "";
  bool _isLoadingQty = false;

  Future<void> refresh_view_cart() async {
    // _productCartProvider.controller.add('updateCart');
    // Future.delayed(Duration(seconds: 2), () {
    //   setState(() {
    //     _isLoadingQty = false;
    //   });
    // });

    try {
      await Provider.of<CartProvider>(context, listen: false)
          .fetchAndSetCartItem(userBranchId, userUniqueId, userMemberId);

      setState(() {
        if (Provider.of<CartProvider>(context, listen: false).success == 1) {
          _isLoadingQty = false;
        }
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
  ) async {
    setState(() {
      _isLoadingQty = true;
    });

    ProductAddToCartRequest productAddToCartRequest = ProductAddToCartRequest(
      productId: productId,
      itemId: itemId,
      qty: qty.toString(),
      uniqueId: userUniqueId,
      mem_id: userMemberId,
      branch_id: userBranchId,
    );
    var response = await _productCartProvider.productAddToCart(
        productAddToCartRequest, context);
    if (response is ProductAddToCartResponse) {
      if (response.success == "0") {
        refresh_view_cart();
      } else {
        setState(() {
          _isLoadingQty = false;
        });
        Fluttertoast.showToast(msg: response.message);
      }
    }
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
          refresh_view_cart();
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
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 0), () {
      userUniqueId = _apiProviders.uid;
      userBranchId = _areaBranchProvider.branch_id_v;
      userMemberId = _userDetailsProvider.userDetails[0].memberId;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _productCartProvider = Provider.of<ProductCartProvider>(context);
    _apiProviders = Provider.of<ApiProviders>(context, listen: false);
    _userDetailsProvider =
        Provider.of<UserDetailsProvider>(context, listen: false);
    _areaBranchProvider =
        Provider.of<AreaBranchProvider>(context, listen: false);
    int itemQty = 0;
    String cartId;
    bool isLoading;
    int cartIndex;
    final cart = Provider.of<CartProvider>(context);
    final contain = cart.items
        .where((item) => item.itemId == widget.itemId.split(',')[_value]);
    if (contain.isNotEmpty) {
      itemQty = int.parse(cart.items
          .where((item) => item.itemId == widget.itemId.split(',')[_value])
          .first
          .quantity);
      cartId = cart.items
          .where(
              (cartItem) => cartItem.itemId == widget.itemId.split(',')[_value])
          .first
          .cartId;
      isLoading = cart.items
          .where(
              (cartItem) => cartItem.itemId == widget.itemId.split(',')[_value])
          .first
          .isLoading;
    }

    _items = getDrowDownItems(
      widget.productSpec.split(',').length,
      widget.productUnit,
      widget.productSpec,
    );
    //for nevigationg
    _productDetailsScreen() {
      String memberId;
      if (Provider.of<UserDetailsProvider>(context, listen: false)
          .userDetails
          .isEmpty) {
        memberId = '';
      } else {
        memberId = Provider.of<UserDetailsProvider>(context, listen: false)
            .userDetails[0]
            .memberId;
      }
      print('hello');
      final uniqueId = Provider.of<ApiProviders>(context, listen: false).uid;

      final branchId =
          Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;
      // print(productSlug);
      Provider.of<ProductDetail>(context, listen: false)
          .fetchAndSetProductDetail(
              widget.productSlug, uniqueId, branchId, memberId);
      return Navigator.of(context)
          .pushNamed(Item_Details.routeName, arguments: {
        'product_name': widget.productName,
        'product_slug': widget.productSlug,
      });
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            padding: EdgeInsets.all(2.0),
                            margin: EdgeInsets.all(2.0),
                            width: 72,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Center(
                              child: Text(
                                'Save ${double.parse(widget.productSavePrice.split(',')[_value]).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            _productDetailsScreen();
                          },
                          child: Container(
                            // margin: EdgeInsets.only(top: 5.0),
                            height: 150.0,
                            width: 150.0,
                            child: Image.network(
                              widget.productImage.split(',')[_value],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5.0),
                        padding: const EdgeInsets.all(0.0),
                        child: InkWell(
                          onTap: () {
                            _productDetailsScreen();
                          },
                          child: Text(
                            '${widget.productName}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _productDetailsScreen();
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '₹ ${widget.productPrice.split(',')[_value]}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '₹ ${widget.productOldPrice.split(',')[_value]}',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.grey,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'You Save ₹${double.parse(widget.productSavePrice.split(',')[_value]).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      (widget.productSpec.split(',').length > 1)
                          ? Row(
                              children: [
                                Container(
                                  width: 150.0,
                                  height: 35.0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                    horizontal: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.themecolor,
                                          width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        value: _value,
                                        items: _items,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value;
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 150.0,
                                  height: 35.0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.themecolor,
                                          width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${widget.productSpec.split(',')[_value]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        '${widget.productUnit.split(',')[_value]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      itemQty == 0
                          ? _isLoadingQty
                              ? Container(
                                  margin: EdgeInsets.only(top: 6.0, right: 50),
                                  height: 20.0,
                                  width: 20.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.themecolor,
                                    ),
                                  ))
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 20.0,
                                        top: 5.0,
                                      ),
                                      width: 150.0,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: AppColors.themecolor,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          addProduct(
                                            widget.productId,
                                            widget.itemId.split(',')[_value],
                                            1,
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Add to Cart',
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
                                // Container(
                                //   margin: EdgeInsets.only(
                                //     left: 20.0,
                                //   ),
                                //   width: 150.0,
                                //   height: 35.0,
                                // ),
                                cart.items
                                        .where((cartItem) =>
                                            cartItem.productId ==
                                            widget.productId)
                                        .first
                                        .isLoading
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 90.0, top: 5.0),
                                        width: 20.0,
                                        height: 20.0,
                                        child: CircularProgressIndicator(
                                          color: AppColors.themecolor,
                                        ))
                                    : Container(
                                        margin: EdgeInsets.only(
                                          right: 20.0,
                                          top: 5.0,
                                        ),
                                        width: 150.0,
                                        height: 35.0,
                                        /*decoration: BoxDecoration(
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
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0)),
                                              child: IconButton(
                                                icon: Icon(_sub_icon(),
                                                    color:
                                                        AppColors.themecolor),
                                                onPressed: () {
                                                  if (cart.items
                                                          .where((cartItem) =>
                                                              cartItem.itemId ==
                                                              widget.itemId
                                                                      .split(
                                                                          ',')[
                                                                  _value])
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
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0)),
                                                child: Center(
                                                  child: Text(
                                                    '${itemQty}',
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
                                              height: 35,
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
