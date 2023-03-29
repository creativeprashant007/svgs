import 'package:flutter/material.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/product_details.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/item_details.dart';
import 'package:provider/provider.dart';

class TopDealProduct extends StatefulWidget {
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
  final Function() notifyParent;

  const TopDealProduct({
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
    @required this.notifyParent,
  }) : super(key: key);

  @override
  _TopDealProductState createState() => _TopDealProductState();
}

class _TopDealProductState extends State<TopDealProduct> {
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
      final branchId =
          Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;

      print("Checking_auto_load============================view_cart");
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
        //  _isLoadingQty = false;

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
    int itemQty = 0;
    String cartId;
    bool isLoading;
    int cartIndex;
    final cart = Provider.of<CartProvider>(context);
    final contain = cart.items
        .where((item) => item.itemId == widget.itemId.split(',')[_value]);

    print(
        "oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    print(itemQty);
    print(contain);
    if (contain.isNotEmpty) {
      itemQty = int.parse(cart.items
          .where((item) => item.itemId == widget.itemId.split(',')[_value])
          .first
          .quantity);

      print("qat=========--------------------------------------------------");
      print(itemQty);

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

      print("1111111111111111111111111111111111111111111111");
    }

    _items = getDrowDownItems(
      widget.productSpec.split(',').length,
      widget.productUnit,
      widget.productSpec,
    );

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
      elevation: 1.5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        width: 175.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  margin: EdgeInsets.all(2.0),
                  // width: 80,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Text(
                    'Save ${double.parse(widget.productSavePrice.split(',')[_value]).toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),

            InkWell(
              onTap: () {
                String memberId;
                if (Provider.of<UserDetailsProvider>(context, listen: false)
                    .userDetails
                    .isEmpty) {
                  memberId = '';
                } else {
                  memberId =
                      Provider.of<UserDetailsProvider>(context, listen: false)
                          .userDetails[0]
                          .memberId;
                }
                print('hello');
                final uniqueId =
                    Provider.of<ApiProviders>(context, listen: false).uid;
                print(uniqueId);

                final branchId =
                    Provider.of<AreaBranchProvider>(context, listen: false)
                        .branch_id_v;
                Provider.of<ProductDetail>(context, listen: false)
                    .fetchAndSetProductDetail(
                        widget.productSlug, uniqueId, branchId, memberId);
                return Navigator.of(context)
                    .pushNamed(Item_Details.routeName, arguments: {
                  'product_name': widget.productName,
                  'product_slug': widget.productSlug,
                });
              },
              child: Container(
                height: 130.0,
                child: Image.network(
                  widget.productImage.split(',')[_value],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                String memberId;
                if (Provider.of<UserDetailsProvider>(context, listen: false)
                    .userDetails
                    .isEmpty) {
                  memberId = '';
                } else {
                  memberId =
                      Provider.of<UserDetailsProvider>(context, listen: false)
                          .userDetails[0]
                          .memberId;
                }
                print('hello');
                final uniqueId =
                    Provider.of<ApiProviders>(context, listen: false).uid;
                print(uniqueId);

                final branchId =
                    Provider.of<AreaBranchProvider>(context, listen: false)
                        .branch_id_v;
                Provider.of<ProductDetail>(context, listen: false)
                    .fetchAndSetProductDetail(
                        widget.productSlug, uniqueId, branchId, memberId);
                return Navigator.of(context)
                    .pushNamed(Item_Details.routeName, arguments: {
                  'product_name': widget.productName,
                  'product_slug': widget.productSlug,
                });
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 38.0,
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      '${widget.productName}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  (widget.productSpec.split(',').length > 1)
                      ? Container(
                          height: 30.0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.themecolor,
                                width: .5,
                              ),
                              borderRadius: BorderRadius.circular(
                                10.0,
                              )),
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                value: _value,
                                focusColor: Colors.grey,
                                items: _items,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                          ),
                        )
                      : Container(
                          height: 30.0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.themecolor, width: 0.5),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            children: [
                              Text(
                                '${widget.productSpec.split(',')[_value]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.grey),
                              ),
                              Text(
                                '${widget.productUnit.split(',')[_value]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '₹${widget.productPrice.split(',')[_value]}',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        '₹${widget.productOldPrice.split(',')[_value]}',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.grey,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///for button
            itemQty == 0
                ? _isLoadingQty
                    ? Container(
                        margin: EdgeInsets.only(top: 4.0),
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: AppColors.themecolor,
                        ))
                    : Container(
                        margin: EdgeInsets.only(top: 4.0),
                        height: 35.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.themecolor,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (cart.items
                                .where((item) =>
                                    item.productId == widget.productId)
                                .isEmpty) {
                              print('false');
                            } else {
                              print('true');
                            }
                            Provider.of<AreaBranchProvider>(context,
                                    listen: false)
                                .fetchAreaDetails();
                            String memberId;
                            if (Provider.of<UserDetailsProvider>(context,
                                    listen: false)
                                .userDetails
                                .isEmpty) {
                              memberId = '';
                            } else {
                              memberId = Provider.of<UserDetailsProvider>(
                                      context,
                                      listen: false)
                                  .userDetails[0]
                                  .memberId;
                            }

                            print(memberId);
                            String uniqueId = Provider.of<ApiProviders>(context,
                                    listen: false)
                                .uid;

                            print(memberId);
                            final branchId = Provider.of<AreaBranchProvider>(
                                    context,
                                    listen: false)
                                .branch_id_v;
                            print('this is branch id ${branchId}');

                            print(uniqueId);
                            addProduct(
                              widget.productId,
                              widget.itemId.split(',')[_value],
                              1,
                              uniqueId,
                              memberId,
                              branchId,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      )
                : cart.items
                        .where((cartItem) =>
                            cartItem.productId == widget.productId)
                        .first
                        .isLoading
                    ? Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: AppColors.themecolor,
                        ))
                    : Container(
                        margin: EdgeInsets.only(
                          top: 6.0,
                        ),
                        height: 30.0,
                        /* decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(9.0)),*/
                        child: Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (cart.items
                                        .where((cartItem) =>
                                            cartItem.itemId ==
                                            widget.itemId.split(',')[_value])
                                        .first
                                        .quantity ==
                                    '1') {
                                  setState(() {
                                    print(
                                        "==========================removeSingleItem===========================");
                                    remove_cart_quantity(cartId);
                                    //cart.removeSingleItem(cartId);
                                  });
                                } else {
                                  cart.items
                                      .where((cartItem) =>
                                          cartItem.productId ==
                                          widget.productId)
                                      .first
                                      .isLoading = true;
                                  print(cart.items
                                      .where((cartItem) =>
                                          cartItem.productId ==
                                          widget.productId)
                                      .first
                                      .isLoading);

                                  final branchId =
                                      Provider.of<AreaBranchProvider>(context,
                                              listen: true)
                                          .branch_id_v;

                                  print(
                                      "==========================MINUS===========================");
                                  print(
                                      'minus----------------------------points' +
                                          cartId +
                                          "\n" +
                                          branchId);
                                  minus_quantity(cartId, branchId);

                                  setState(() {
                                    cart.items
                                        .where((cartItem) =>
                                            cartItem.productId ==
                                            widget.productId)
                                        .first
                                        .isLoading = true;
                                  });
                                }
                              },
                              child: Container(
                                width: 45,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(0.0)),
                                child: Center(
                                  child: Icon(_sub_icon(),
                                      color: AppColors.themecolor),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2.0),
                            ),
                            Container(
                                width: 65,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(0.0)),
                                child: Center(
                                  child: Text(
                                    '${itemQty}',
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.only(right: 2.0),
                            ),
                            InkWell(
                              onTap: () {
                                print(cart.items
                                    .where((cartItem) =>
                                        cartItem.productId == widget.productId)
                                    .first
                                    .isLoading);

                                cart.items
                                    .where((cartItem) =>
                                        cartItem.productId == widget.productId)
                                    .first
                                    .isLoading = true;
                                print(
                                    '=========++++++creative loading+==============');

                                print(cart.items
                                    .where((cartItem) =>
                                        cartItem.productId == widget.productId)
                                    .first
                                    .isLoading);

                                final branchId =
                                    Provider.of<AreaBranchProvider>(context,
                                            listen: false)
                                        .branch_id_v;

                                add_quantity(cartId, branchId);

                                setState(() {
                                  cart.items
                                      .where((cartItem) =>
                                          cartItem.productId ==
                                          widget.productId)
                                      .first
                                      .isLoading = true;
                                });
                              },
                              child: Container(
                                width: 45,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(0.0)),
                                child: Center(
                                    child:
                                        Icon(_add_icon(), color: Colors.black)),
                              ),
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
