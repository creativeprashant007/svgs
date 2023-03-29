import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:provider/provider.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/categories/categories_product_list.dart';

import '../../../providers/categories.dart';
import '../../../providers/category_product_listing.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final searchController = TextEditingController();

  //========================================================== SHARIYATH ===========================================
  Future<void> cat_pro_req(
      String alias,
      String uniqueId,
      String branchId,
      String memberId,
      int page,
      int pos_cat,
      int pos_sub,
      String click_name) async {
    if (click_name == "sub") {
      Navigator.of(context).pushNamed(CategoriesProduct.routeName, arguments: {
        'cat_name': Provider.of<CategoriesProvider>(context, listen: false)
            .cat_items[pos_cat]
            .subCatName
            .split(',')[pos_sub],
        'cat_slug': Provider.of<CategoriesProvider>(context, listen: false)
            .cat_items[pos_cat]
            .subCatSlug
            .split(',')[pos_sub],
        'sub_cat_id': Provider.of<CategoriesProvider>(context, listen: false)
            .cat_items[pos_cat]
            .sub_cat_id
            .split(',')[pos_sub]
      });
    } else {
      Navigator.of(context).pushNamed(CategoriesProduct.routeName, arguments: {
        'cat_name': Provider.of<CategoriesProvider>(context, listen: false)
            .cat_items[pos_cat]
            .categoryname,
        'cat_slug': Provider.of<CategoriesProvider>(context, listen: false)
            .cat_items[pos_cat]
            .catslug
      });
    }
    // try {
    //   setState(() {
    //     _isLoggedIn = true;
    //   });

    //   if (click_name == "sub") {
    //     await Provider.of<CategoryProductListingProvider>(
    //       context,
    //       listen: false,
    //     ).fetchAndSetCategoryProduct(
    //       alias,
    //       uniqueId,
    //       branchId,
    //       memberId,
    //       1,
    //     );
    //   } else {
    //     await Provider.of<CategoryProductListingProvider>(context,
    //             listen: false)
    //         .fetchAndSetCategoryProduct(
    //       alias,
    //       uniqueId,
    //       branchId,
    //       memberId,
    //       1,
    //     );
    //   }

    //   print(
    //       "checking_cat_pro_req_vera_level============================cat_pro_req");

    //   final success =
    //       Provider.of<CategoryProductListingProvider>(context, listen: false)
    //           .success;

    //   print("success_cat_pro_req============================view_cart$success");

    //   if (success == 1) {
    //     setState(() {
    //       _isLoggedIn = false;

    //       if (click_name == "sub") {
    //         Navigator.of(context)
    //             .pushNamed(CategoriesProduct.routeName, arguments: {
    //           'cat_name':
    //               Provider.of<CategoriesProvider>(context, listen: false)
    //                   .cat_items[pos_cat]
    //                   .subCatName
    //                   .split(',')[pos_sub],
    //           'cat_slug':
    //               Provider.of<CategoriesProvider>(context, listen: false)
    //                   .cat_items[pos_cat]
    //                   .subCatSlug
    //                   .split(',')[pos_sub],
    //           'sub_cat_id':
    //               Provider.of<CategoriesProvider>(context, listen: false)
    //                   .cat_items[pos_cat]
    //                   .sub_cat_id
    //                   .split(',')[pos_sub]
    //         });
    //       } else {
    //         Navigator.of(context)
    //             .pushNamed(CategoriesProduct.routeName, arguments: {
    //           'cat_name':
    //               Provider.of<CategoriesProvider>(context, listen: false)
    //                   .cat_items[pos_cat]
    //                   .categoryname,
    //           'cat_slug':
    //               Provider.of<CategoriesProvider>(context, listen: false)
    //                   .cat_items[pos_cat]
    //                   .catslug
    //         });
    //       }
    //     });
    //   }
    // } catch (error) {
    //   print("----------------------------------$error");
    //   throw (error);
    // }
  } // refresh_view_cart
  // ----------------------------------------------------------------------------------------------------

  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoriesProvider>(context).cat_items;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.themecolor,
          leading: Icon(
            Icons.dashboard,
            color: AppColors.whiteColor,
          ),
          title: Text(
            'Shop By Category',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor),
          ),
        ),
        body: Container(
          child: ModalProgressHUD(
            inAsyncCall: _isLoggedIn,
            progressIndicator: CircularProgressIndicator(
              color: AppColors.themecolor,
            ),
            child: categories.length <= 0
                ? Container(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.themecolor,
                    )),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, i) {
                      return Card(
                          //for category
                          child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              setState(() {
                                categories[i].isExpanded =
                                    !categories[i].isExpanded;
                              });
                            },
                            title: Text(
                              categories[i].categoryname,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(categories[i].isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more),
                              onPressed: () {
                                //clickedCatIndex = i;
                                setState(() {
                                  categories[i].isExpanded =
                                      !categories[i].isExpanded;
                                });
                              },
                            ),
                          ),
                          if (categories[i].isExpanded)
                            //for sub category
                            Container(
                              // height:
                              //     categories[i].subCatName.split(',').length ==
                              //             1
                              //         ? 80.0
                              //         : 80.0 *
                              //             categories[i]
                              //                 .subCatName
                              //                 .split(',')
                              //                 .length,
                              child: ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    categories[i].subCatName.split(',').length,
                                itemBuilder: (context, j) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      j == 0 ? Divider() : Container(),
                                      InkWell(
                                        onTap: () {
                                          final uniqueId =
                                              Provider.of<ApiProviders>(context,
                                                      listen: false)
                                                  .uid;
                                          final branchId =
                                              Provider.of<AreaBranchProvider>(
                                                      context,
                                                      listen: false)
                                                  .branch_id_v;
                                          String memberId;
                                          if (Provider.of<UserDetailsProvider>(
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
                                          final alias = categories[i]
                                              .subCatSlug
                                              .split(',')[j];

                                          print("heddddddddddddddddddddddddds");
                                          print(alias);
                                          print(uniqueId);
                                          print("${branchId}");
                                          print("${memberId}");
                                          print("${i}");
                                          print("${j}");
                                          cat_pro_req(alias, uniqueId, branchId,
                                              memberId, 1, i, j, "sub");
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 5),
                                          child: Text(
                                            categories[i]
                                                .subCatName
                                                .split(',')[j],
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                        ],
                      ));
                    },
                  ),
          ),
        ));
  }
}
