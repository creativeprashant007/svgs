import 'dart:async';

import 'package:flutter/material.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/model/banner.dart' as banner;
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/banner_provider.dart';
import 'package:svgs_app/providers/product_details.dart';
import 'package:svgs_app/providers/search_provider.dart';
import 'package:svgs_app/providers/shop_categories_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/categories/categories_product_list.dart';
import 'package:svgs_app/src/ui/home/product_banners_by_slug.dart';
import 'package:svgs_app/src/ui/search/search_product.dart';
import 'package:svgs_app/widgets/home/category_item.dart';
import 'package:svgs_app/widgets/home/top_deal.dart';
import 'package:svgs_app/widgets/home/view_all_top_deal.dart';
import 'package:svgs_app/widgets/simmer/simmer_banner.dart';

import 'package:provider/provider.dart';
import '../../../widgets/cap.dart';

import '../../item_details.dart';
import 'banner_details.dart';

class FirstPage extends StatefulWidget {
  static final routeName = '/first';
  @override
  _FirstPageState createState() => _FirstPageState();
}

class GridItemModel {
  String longtext;
  GlobalKey itemKey;
  double width;
  double height;
  GridItemModel(this.longtext) {
    itemKey = GlobalKey();
  }
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  TabController tabController;
  List properties = [];
  List<dynamic> imagebanner = [];
  final List<String> imageCategories = [];

  List today_deals;

  bool _isLoggedIn = false;
  int index = 1;
  int index2 = 1;
  ShapeBorder shapeBorder;

  double rating = 3.5;
  double rating1 = 4.5;

  List data, imagebanner_test;
  List data_banner, data_categories, data_new_arrivals;
  int _pageNumber = 1;
  Future<void> search_products_req(
    String prodPattern,
    String uniqueId,
    String branchId,
    String memberId,
  ) async {
    Navigator.of(context).pushNamed(SearchProducts.routeName, arguments: {
      'pattern': prodPattern,
    });
    // try {
    //   setState(() {
    //     _isLoggedIn = true;
    //   });

    //   await Provider.of<SearchProvider>(context, listen: false)
    //       .fetchAndSetSearchItem(
    //           prodPattern, uniqueId, branchId, memberId, _pageNumber);

    //   print(
    //       "checking_cat_pro_req_vera_level============================cat_pro_req");

    //   // final success =
    //   //     Provider.of<CategoryProductListingProvider>(context).success;

    //   //   print("success_cat_pro_req============================view_cart$success");

    //   // if (success == 1) {
    //   setState(() {
    //     _isLoggedIn = false;

    //     Navigator.of(context).pushNamed(SearchProducts.routeName, arguments: {
    //       'pattern': prodPattern,
    //     });
    //   });
    //   //   }
    // } catch (error) {
    //   print("----------------------------------$error");
    //   throw (error);
    // }
  } // refresh_view_cart

  var myDynamicAspectRatio = 1000 / 1;
  OverlayEntry sticky;
  List<GridItemModel> myGridList = new List();
  double maxHeight = 0;
  double maxWidth = 0;

  @override
  void initState() {
    super.initState();
    //Provider.of<TopDealProducts>(context).fetchAndSetTopDealProduct();

    tabController = new TabController(length: 5, vsync: this);
  }

  Widget stickyBuilder(BuildContext context) {
    for (GridItemModel gi in myGridList) {
      if (gi.width == null) {
        final keyContext = gi.itemKey.currentContext;
        if (keyContext != null) {
          final box = keyContext.findRenderObject() as RenderBox;
          print(box.size.height);
          print(box.size.width);
          gi.width = box.size.width;
          gi.height = box.size.height;
        }
      }
    }
    shouldUpdateGridList();
    return Container();
  }

  shouldUpdateGridList() {
    bool isChanged = false;
    for (GridItemModel gi in myGridList) {
      if (gi.width != null) {
        if (gi.height > maxHeight) {
          maxHeight = gi.height;
          maxWidth = gi.width;
          isChanged = true;
        }
      }
    }
    if (isChanged) {
      myDynamicAspectRatio = maxWidth / maxHeight;
      print("AspectRatio" + myDynamicAspectRatio.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _current = 0;
  int _current2 = 0;
  @override
  Widget build(BuildContext context) {
    print("checking_loaded---------------------------------");

    final bannerItems = Provider.of<BannerProvider>(context).bannerItems;
    final offerItems = Provider.of<BannerProvider>(context).offerItems;
    final shopCategories =
        Provider.of<ShopCategoriesProvider>(context).shop_categories_items;

    print("checking_loaded---------------------------------");
    print(shopCategories.length);
    print(shopCategories.length / 2);

    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline1.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subtitle1;

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    double cellWidth =
        ((MediaQuery.of(context).size.width) / shopCategories.length);

    return Expanded(
        child: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                color: AppColors.whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: new Column(
                  children: <Widget>[
                    bannerItems.length < 1
                        ? SimmerBanner()
                        : Stack(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                    height: 200,
                                    aspectRatio: 2,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    disableCenter: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                    // enlargeCenterPage: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                                items: bannerItems
                                    .map((item) => InkWell(
                                          onTap: () {
                                            var title = bannerItems[_current]
                                                .bannerSlug
                                                .split('-');
                                            var title1 = title.join(' ');
                                            if (bannerItems[_current]
                                                    .bannerSlugType ==
                                                "category") {
                                              Navigator.of(context).pushNamed(
                                                  CategoriesProduct.routeName,
                                                  arguments: {
                                                    'cat_name': '${title1}'
                                                        .capitalizeFirstofEach,
                                                    'cat_slug':
                                                        bannerItems[_current]
                                                            .bannerSlug,
                                                    'sub_cat_id':
                                                        bannerItems[_current]
                                                            .catId,
                                                  });
                                            } else if (bannerItems[_current]
                                                    .bannerSlugType ==
                                                "product") {
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
                                              print('hello');
                                              final uniqueId =
                                                  Provider.of<ApiProviders>(
                                                          context,
                                                          listen: false)
                                                      .uid;
                                              print(uniqueId);

                                              final branchId = Provider.of<
                                                          AreaBranchProvider>(
                                                      context,
                                                      listen: false)
                                                  .branch_id_v;

                                              Provider.of<ProductDetail>(
                                                      context,
                                                      listen: false)
                                                  .fetchAndSetProductDetail(
                                                      bannerItems[_current]
                                                          .bannerSlug,
                                                      uniqueId,
                                                      branchId,
                                                      memberId);
                                              // Provider.of<ProductDetail>(
                                              //         context,
                                              //         listen: false)
                                              //     .fetchAndSetProductDetail(
                                              //         bannerItems[_current]
                                              //             .bannerSlug,
                                              //         uniqueId,
                                              //         branchId,
                                              //         memberId);
                                              Navigator.of(context).pushNamed(
                                                  Item_Details.routeName,
                                                  arguments: {
                                                    'product_name': title1
                                                        .capitalizeFirstofEach,
                                                    'product_slug':
                                                        bannerItems[_current]
                                                            .bannerSlug,
                                                  });
                                            } else if (bannerItems[_current]
                                                    .bannerSlugType ==
                                                "keyword") {
                                              print('i am here');
                                              final productPattern =
                                                  "${bannerItems[_current].bannerSlug}";

                                              final uniqueId =
                                                  Provider.of<ApiProviders>(
                                                          context,
                                                          listen: false)
                                                      .uid;
                                              final branchId = Provider.of<
                                                          AreaBranchProvider>(
                                                      context,
                                                      listen: false)
                                                  .branch_id_v;
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
                                                  listen: false,
                                                )
                                                    .userDetails[0]
                                                    .memberId
                                                    .toString()
                                                    .trim();
                                              }

                                              print('------------i am here');
                                              search_products_req(
                                                  productPattern,
                                                  uniqueId,
                                                  branchId,
                                                  memberId);
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            child: new CachedNetworkImage(
                                              height: 200.0,
                                              // width: double.infinity,
                                              fit: BoxFit.fill,
                                              //   fit: BoxFit.contain,
                                              imageUrl: item.bannerImage,

                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                              fadeOutDuration:
                                                  new Duration(seconds: 1),
                                              fadeInDuration:
                                                  new Duration(seconds: 3),
                                            ),
                                            //child: Image.network(item, fit: BoxFit.cover, width: 1000)
                                          ),
                                        ))
                                    .toList(),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.4,
                                bottom: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: bannerItems.map((banner) {
                                    int index = bannerItems.indexOf(banner);
                                    // print(index);
                                    return Container(
                                      width: _current == index ? 11 : 8.0,
                                      height: _current == index ? 11 : 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? Color.fromRGBO(0, 0, 0, 0.9)
                                            : Color.fromRGBO(0, 0, 0, 0.1),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                    Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Featured Products',
                                style: TextStyles.h1Heading,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AllTopDealProduct.routeName);
                                },
                                child: Text('VIEW ALL',
                                    style: TextStyles.themeColorText),
                              ),
                              //TitleText(text: "My XS-Points", fontSize: 25),
                            ])),
                    //Top Deals Product
                    Container(
                      color: Colors.grey[100],
                      height: 315.0,
                      child: TopDeal(),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Offers',
                        style: TextStyles.h1Heading,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    _sliderBanner(bannerList: offerItems, current: _current2),
                    SizedBox(
                      height: 3.0,
                    ),
                    Card(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.themecolor,
                            width: 2.0,
                          ),
                        ),
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('━ Shop By Category ━',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: AppColors.themecolor,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          shopCategories.length <= 0
              ? Center(child: CircularProgressIndicator())
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    itemCount: shopCategories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (c, i) {
                      return CategoryItem(
                        slug: shopCategories[i].catSlug,
                        catName: shopCategories[i].catName,
                        catImage: shopCategories[i].catImage,
                        catid: shopCategories[i].catid,
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0),
                  ),
                ),
        ])),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 16.0,
              ),
              InkWell(
                  onTap: () {
                    print('i am here');
                    final productPattern = "svgs";

                    final uniqueId =
                        Provider.of<ApiProviders>(context, listen: false).uid;
                    final branchId =
                        Provider.of<AreaBranchProvider>(context, listen: false)
                            .branch_id_v;
                    String memberId;
                    if (Provider.of<UserDetailsProvider>(context, listen: false)
                        .userDetails
                        .isEmpty) {
                      memberId = '';
                    } else {
                      memberId = Provider.of<UserDetailsProvider>(
                        context,
                        listen: false,
                      ).userDetails[0].memberId.toString().trim();
                    }

                    print('------------i am here');
                    search_products_req(
                        productPattern, uniqueId, branchId, memberId);
                  },
                  child: Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("View More", style: TextStyles.actionTitle_p),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.themecolor,
                      ),
                    ],
                  ))),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _sliderBanner({List<banner.Banner> bannerList, int current}) {
    return bannerList.length < 1
        ? SimmerBanner()
        : Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    disableCenter: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current2 = index;
                      });
                    }),
                items: bannerList
                    .map(
                      (item) => InkWell(
                        onTap: () {
                          var title =
                              bannerList[_current2].bannerSlug.split('-');
                          var title1 = title.join(' ');
                          if (bannerList[_current2].bannerSlugType ==
                              "category") {
                            Navigator.of(context).pushNamed(
                                CategoriesProduct.routeName,
                                arguments: {
                                  'cat_name': '${title1}'.capitalizeFirstofEach,
                                  'cat_slug': bannerList[_current2].bannerSlug,
                                  'sub_cat_id': bannerList[_current2].catId,
                                });
                          } else if (bannerList[_current2].bannerSlugType ==
                              "product") {
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
                            print('hello');
                            final uniqueId = Provider.of<ApiProviders>(context,
                                    listen: false)
                                .uid;
                            print(uniqueId);

                            final branchId = Provider.of<AreaBranchProvider>(
                                    context,
                                    listen: false)
                                .branch_id_v;

                            Provider.of<ProductDetail>(context, listen: false)
                                .fetchAndSetProductDetail(
                                    bannerList[_current2].bannerSlug,
                                    uniqueId,
                                    branchId,
                                    memberId);
                            // Provider.of<ProductDetail>(
                            //         context,
                            //         listen: false)
                            //     .fetchAndSetProductDetail(
                            //         bannerList[_current2]
                            //             .bannerSlug,
                            //         uniqueId,
                            //         branchId,
                            //         memberId);
                            Navigator.of(context)
                                .pushNamed(Item_Details.routeName, arguments: {
                              'product_name': title1.capitalizeFirstofEach,
                              'product_slug': bannerList[_current2].bannerSlug,
                            });
                          } else if (bannerList[_current2].bannerSlugType ==
                              "keyword") {
                            print('i am here');
                            final productPattern =
                                "${bannerList[_current2].bannerSlug}";

                            final uniqueId = Provider.of<ApiProviders>(context,
                                    listen: false)
                                .uid;
                            final branchId = Provider.of<AreaBranchProvider>(
                                    context,
                                    listen: false)
                                .branch_id_v;
                            String memberId;
                            if (Provider.of<UserDetailsProvider>(context,
                                    listen: false)
                                .userDetails
                                .isEmpty) {
                              memberId = '';
                            } else {
                              memberId = Provider.of<UserDetailsProvider>(
                                context,
                                listen: false,
                              ).userDetails[0].memberId.toString().trim();
                            }

                            print('------------i am here');
                            search_products_req(
                                productPattern, uniqueId, branchId, memberId);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          child: new CachedNetworkImage(
                            height: 200.0,
                            // width: double.infinity,
                            fit: BoxFit.fill,
                            //   fit: BoxFit.contain,
                            imageUrl: item.bannerImage,

                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                            fadeOutDuration: new Duration(seconds: 1),
                            fadeInDuration: new Duration(seconds: 3),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: bannerList.map((banner) {
                    int index = bannerList.indexOf(banner);
                    // print(index);
                    return Container(
                      width: _current2 == index ? 11 : 8.0,
                      height: _current2 == index ? 11 : 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current2 == index
                            ? Color.fromRGBO(
                                0,
                                0,
                                0,
                                0.9,
                              )
                            : Color.fromRGBO(
                                0,
                                0,
                                0,
                                0.1,
                              ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
  }
}
