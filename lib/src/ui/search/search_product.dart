import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/model/Category_Pro_Model.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/search_products_provider.dart';
import 'package:svgs_app/providers/search_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/cart/fifth.dart';
import 'package:svgs_app/src/ui/home/homepage.dart';
import 'package:svgs_app/widgets/badge.dart';
import 'package:svgs_app/widgets/home/product_listing.dart';
import 'package:svgs_app/widgets/simmer/product_list_simmer.dart';
import '../../../widgets/cap.dart';

class SearchProducts extends StatefulWidget {
  static const routeName = '/search-prodcut';
  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  List search_product = [];
  int _pageNumber = 1;
  String search_name = "";
  bool prgress_bar = false;
  bool _isLoggedIn = false;
  bool _isProgress = true;
  ScrollController _scrollController = ScrollController();
  Future<void> _search_product_list(String pattern) async {
    // final form = formKey.currentState;
    //   form.save();

    // ---- pattern
    String memberId;
    if (Provider.of<UserDetailsProvider>(context, listen: false)
        .userDetails
        .isEmpty) {
      memberId = '';
    } else {
      memberId = Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      ).userDetails[0].memberId;
    }
    print('hello');
    final uniqueId = Provider.of<ApiProviders>(
      context,
      listen: false,
    ).uid;
    print(uniqueId);

    final branchId = Provider.of<AreaBranchProvider>(
      context,
      listen: false,
    ).branch_id_v;
    print("pattern-------------------------------");
    print(pattern);

    try {
      setState(() {
        if (_pageNumber == 1) {
          _isProgress = true;
        }
      });
      await Provider.of<SearchProductProvider>(
        context,
        listen: false,
      ).fetchAndSetSearchProItem(
          branchId, pattern, uniqueId, memberId, _pageNumber);

      print("SearchProvider---------------------------------testing");

      final products = Provider.of<SearchProductProvider>(
        context,
        listen: false,
      ).searchItem;

      final int_last_page = Provider.of<SearchProductProvider>(
        context,
        listen: false,
      ).last_page;
      print("int_last_page---------------------------------int_last_page");
      print(int_last_page);

      if (_pageNumber <= int_last_page) {
        if (!products.isEmpty) {
          //final otp = Provider.of<SendOtpProvider>(context).otp;
          print("productsssssss=================================#############");
          print(products[0].productName);

          setState(() {
            /*if (!search_product.isEmpty) {
            search_product.clear();
          }*/

            for (int i = 0; i < products.length; i++) {
              Map<String, dynamic> map = new Map<String, dynamic>();
              map['product_id'] = products[i].productId;
              map['product_name'] = products[i].productName;
              map['product_slug'] = products[i].productSlug;
              map['item_id'] = products[i].productItemId;
              map['item_image'] = products[i].productImage;
              map['item_mrp'] = products[i].productItemsOldPrice;
              map['item_sellprice'] = products[i].productItemsOrginalSellprice;
              map['save_pri'] = products[i].productItemsDiscount;
              map['item_spec'] = products[i].productItemsSpec;
              map['item_unit'] = products[i].productItemsUnit;

              // map['area_country'] = products[i].area_country;
              // map['area_state'] = products[i].area_state;
              // map['area_city'] = products[i].area_city;

              search_product.add(map);
            }

            print(
                "search_product_isProgress=================================$search_product");
            if (_pageNumber == 1) {
              _isProgress = false;
            } else {
              prgress_bar = false;
            }
          });
        } else {
          setState(() {
            if (_pageNumber == 1) {
              _isProgress = false;
            } else {
              prgress_bar = false;
            }
          });
        }
      } else {
        setState(() {
          if (_pageNumber == 1) {
            _isProgress = false;
          } else {
            prgress_bar = false;
          }
        });
      }
    } catch (error) {
      if (_pageNumber == 1) {
        _isProgress = false;
      } else {
        prgress_bar = false;
      }
      print("error====================================");

      print("----------------------------------$error");
      throw error;
    }
  }

  int _defaultChoiceIndex = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    print("ontheway-----------------------------");
    print("00000000000000000000000000000000000");

    Future.delayed(Duration.zero).then((value) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      String title = routeArgs['pattern'];
      _search_product_list(title);
    });

    _scrollController.addListener(() {
      print('qwe--------------------------123');
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _pageNumber = _pageNumber + 1;

        setState(() {
          prgress_bar = true;
        });

        final int_last_page = Provider.of<SearchProductProvider>(
          context,
          listen: false,
        ).last_page;

        print('json___________________pack------------------------');
        print(int_last_page);

        if (_pageNumber <= int_last_page) {
          final routeArgs =
              ModalRoute.of(context).settings.arguments as Map<String, String>;
          String title = routeArgs['pattern'];
          _search_product_list(title);
          //_getMoreData(_pageNumber);
        } else {
          print('json__123_45________________pack------------------------');
          print(int_last_page);
          setState(() {
            prgress_bar = false;
          });
        }
        print('qwe--------------------------12345');
      }
    });

    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    String title = routeArgs['pattern'];
    /*List<Product> loadedProduct =
        Provider.of<SearchProvider>(context).searchItem;*/
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.themecolor,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            '${title}'.capitalizeFirstofEach,
            style: TextStyles.actionTitle_w,
          ),
          actions: [
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
        body: search_product.length == 0
            ? ProductListSimmer()
            : Container(
                child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      //padding: const EdgeInsets.all(5.0),
                      //  controller: _scrollController,
                      itemCount: search_product.length,
                      controller: _scrollController,
                      itemBuilder: (c, i) {
                        print(
                            "=================================SHARIYATH===============================");
                        print("-------------------------------------$i");
                        print(search_product.length - 1);

                        // =========================================== SHARIYATH ====================================
                        // THIS CODE PRODUCT NOT LOAD CAN YOU CHECK SIGNGLE PRODUCTS
                        // I HOPE YOU UNDER STOOD
                        /*if (i == search_product.length - 1) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }*/
                        return Column(
                          children: [
                            ProductListing(
                              itemId: search_product[i]['item_id'],
                              productId: search_product[i]['product_id'],
                              productName: search_product[i]['product_name'],
                              productImage: search_product[i]['item_image'],
                              productPrice: search_product[i]['item_sellprice'],
                              productOldPrice: search_product[i]['item_mrp'],
                              productSavePrice: search_product[i]['save_pri'],
                              productSlug: search_product[i]['product_slug'],
                              productSpec: search_product[i]['item_spec'],
                              productUnit: search_product[i]['item_unit'],
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: prgress_bar,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20, top: 12),
                        child: CircularProgressIndicator(
                          color: AppColors.themecolor,
                        ),
                      ),
                    ),
                  ),
                ],
              )));
  }
}
