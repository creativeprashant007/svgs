import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/categories.dart';
import 'package:svgs_app/providers/category_product_listing.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/cart/fifth.dart';
import 'package:svgs_app/widgets/badge.dart';
import 'package:svgs_app/widgets/home/product_listing.dart';
import 'package:svgs_app/widgets/simmer/product_list_simmer.dart';
import '../../../widgets/cap.dart';
import 'homepage.dart';

class BannerProducts extends StatefulWidget {
  static const String routeName = "banner-products";
  @override
  _BannerProductsState createState() => _BannerProductsState();
}

class _BannerProductsState extends State<BannerProducts> {
  ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> loadedProduct = [];
  bool prgress_bar = false;
  int _pageNumber = 1;
  String catSlug;
  String catSlug_all;
  String sub_cat_id_all;
  int _defaultChoiceIndex = 0;
  int _selectedIndex = 0;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      catSlug = routeArgs['cat_slug'].toString().trim();

      //Provider.of<CategoriesProvider>(context).fetchAndSetSubSubCategories(sub_cat_id);
      _getMoreData(_pageNumber);
    });

    super.initState();
    _scrollController.addListener(() {
      print('qwe--------------------------123');
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _pageNumber = _pageNumber + 1;

        setState(() {
          prgress_bar = true;
        });

        final int_last_page =
            Provider.of<CategoryProductListingProvider>(context, listen: false)
                .last_page;

        print('json___________________pack------------------------');
        print(int_last_page);

        print(_defaultChoiceIndex);

        if (_pageNumber <= int_last_page) {
          _getMoreData(_pageNumber);
        } else {
          print('json__123_________________pack------------------------');
          print(int_last_page);
          setState(() {
            prgress_bar = false;
          });
        }
        print('qwe--------------------------12345');
      }
    });
  }

  _getMoreData(int _page) {
    print('hey creative you are here');

    final uniqueId = Provider.of<ApiProviders>(context, listen: false).uid;
    final branchId =
        Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;
    String memberId;
    if (Provider.of<UserDetailsProvider>(context, listen: false)
        .userDetails
        .isEmpty) {
      memberId = '';
    } else {
      memberId = Provider.of<UserDetailsProvider>(context, listen: false)
          .userDetails[0]
          .memberId
          .toString()
          .trim();
    }

    print("heddddddddddddddddddddddddd");

    print(uniqueId);
    print("${branchId}");
    print("${memberId}");

    if (_page == 1) {
      if (!loadedProduct.isEmpty) {
        loadedProduct.clear();
      }
    }

    print("99999999999999999999999999999999999999999");

    print("b" + catSlug);

    loaded_pro_details(catSlug, uniqueId, branchId, memberId, _page);

    /*Provider.of<CategoryProductListingProvider>(
      context,
    ).fetchAndSetCategoryProduct(catSlug, uniqueId, branchId, memberId, _page);
    
*/
    setState(() {});
  }

  Future<void> Categories_sub_loaded(String sub_cat_id) async {
    try {
      setState(() {
        Provider.of<CategoriesProvider>(context, listen: false)
            .fetchAndSetSubSubCategories(sub_cat_id);
      });

      print(
          "pro_loaded------------============================loaded_pto_details");
    } catch (error) {
      print("qsc----------------------------------$error");
      throw (error);
    }
  }

  Future<void> loaded_pro_details(String catSlug, String uniqueId,
      String branchId, String memberId, int _page) async {
    try {
      await Provider.of<CategoryProductListingProvider>(context, listen: false)
          .fetchAndSetCategoryProduct(
              catSlug, uniqueId, branchId, memberId, _page);

      print(
          "pro_loaded------------============================loaded_pto_details");

      print(Provider.of<CategoryProductListingProvider>(context, listen: false)
          .category_Product_items
          .length);
      print(Provider.of<CategoryProductListingProvider>(context, listen: false)
          .success);

      print(Provider.of<CategoryProductListingProvider>(context, listen: false)
          .last_page);

      final int_last_page =
          Provider.of<CategoryProductListingProvider>(context, listen: false)
              .last_page;
      if (_page <= int_last_page) {
        if (Provider.of<CategoryProductListingProvider>(context, listen: false)
                .success ==
            1) {
          final list_pro = Provider.of<CategoryProductListingProvider>(context,
                  listen: false)
              .category_Product_items;

          for (int i = 0;
              i <
                  Provider.of<CategoryProductListingProvider>(context,
                          listen: false)
                      .category_Product_items
                      .length;
              i++) {
            var productId = list_pro[i].productId;
            var productName = list_pro[i].productName;
            var productSlug = list_pro[i].productSlug;
            var productItemId = list_pro[i].productItemId;
            var productImage = list_pro[i].productImage;
            var productItemsOldPrice = list_pro[i].productItemsOldPrice;
            var productItemsOrginalSellprice =
                list_pro[i].productItemsOrginalSellprice;
            var productItemsDiscount = list_pro[i].productItemsDiscount;
            var productItemsSpec = list_pro[i].productItemsSpec;
            var productItemsUnit = list_pro[i].productItemsUnit;
            //productCatSlug: category_product['cate_list']['name'],

            final Map<String, dynamic> data = new Map<String, dynamic>();
            data['productId'] = productId;
            data['productName'] = productName;
            data['productSlug'] = productSlug;
            data['productItemId'] = productItemId;
            data['productImage'] = productImage;
            data['productItemsOldPrice'] = productItemsOldPrice;
            data['productItemsOrginalSellprice'] = productItemsOrginalSellprice;
            data['productItemsDiscount'] = productItemsDiscount;
            data['productItemsSpec'] = productItemsSpec;
            data['productItemsUnit'] = productItemsUnit;

            loadedProduct.add(data);
          }

          print("loadedProduct============================loadedProduct");
          print(loadedProduct);
        }
      }

      setState(() {
        prgress_bar = false;
        print("setState============================setState_refresh");
      });
    } catch (error) {
      print("qsc----------------------------------$error");
      throw (error);
    }
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
    var catName = routeArgs['cat_slug'].split('-');
    var appBar = catName.join(' ');
    var appBar1 = appBar.split('and');
    var appBar2 = appBar1.join('and').capitalizeFirstofEach;
    /*  List<Product> loadedProduct =
        Provider.of<CategoryProductListingProvider>(context)
            .category_Product_items;*/

    print("Thangamari============================================");
    print(loadedProduct);
    //print(loadedProduct.length);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: AppColors.themecolor,
          title: Text(
            '$appBar2',
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
        body: SafeArea(
          child: Column(
            children: [
              //_buildChoice(),

              SizedBox(height: 16.0),

              Expanded(
                child: loadedProduct.length == 0
                    ? ProductListSimmer()
                    : ListView.builder(
                        //padding: const EdgeInsets.all(5.0),
                        controller: _scrollController,
                        itemCount: loadedProduct.length,
                        itemBuilder: (c, i) {
                          print(
                              "=================================SHARIYATH===============================");
                          print("-------------------------------------$i");
                          print(loadedProduct.length - 1);

                          // =========================================== SHARIYATH ====================================
                          // THIS CODE PRODUCT NOT LOAD CAN YOU CHECK SIGNGLE PRODUCTS
                          // I HOPE YOU UNDER STOOD
                          /*if (i == loadedProduct.length - 1) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }*/
                          return Column(
                            children: [
                              ProductListing(
                                itemId: loadedProduct[i]['productItemId'],
                                productId: loadedProduct[i]['productId'],
                                productName: loadedProduct[i]['productName'],
                                productImage: loadedProduct[i]['productImage'],
                                productPrice: loadedProduct[i]
                                    ['productItemsOrginalSellprice'],
                                productOldPrice: loadedProduct[i]
                                    ['productItemsOldPrice'],
                                productSavePrice: loadedProduct[i]
                                    ['productItemsDiscount'],
                                productSlug: loadedProduct[i]['productSlug'],
                                productSpec: loadedProduct[i]
                                    ['productItemsSpec'],
                                productUnit: loadedProduct[i]
                                    ['productItemsUnit'],
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
                          )))),
            ],
          ),
        ));
  }
}
