import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/categories.dart';
import 'package:svgs_app/providers/shop_categories_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/categories/categories_product_list.dart';
import '../.././providers/category_product_listing.dart';

class CategoryItem extends StatefulWidget {
  final String slug;
  final String catName;
  final String catImage;
  final String catid;

  const CategoryItem({
    Key key,
    @required this.slug,
    @required this.catName,
    @required this.catImage,
    @required this.catid,
  }) : super(
          key: key,
        );

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
//...................
  //========================================================== SHARIYATH ===========================================
  Future<void> cat_pro_req(String catName, String alias, String uniqueId,
      String branchId, String memberId, int page) async {
    Navigator.of(context).pushNamed(CategoriesProduct.routeName, arguments: {
      'cat_name': catName,
      'cat_slug': alias,
      'sub_cat_id': widget.catid
    });
    // try {
    //   setState(() {
    //     _isLoggedIn = true;
    //   });

    //   await Provider.of<CategoryProductListingProvider>(context, listen: false)
    //       .fetchAndSetCategoryProduct(
    //     alias,
    //     uniqueId,
    //     branchId,
    //     memberId,
    //     1,
    //   );

    //   print(
    //       "checking_cat_pro_req_vera_level============================cat_pro_req");

    //   final success =
    //       Provider.of<CategoryProductListingProvider>(context, listen: false)
    //           .success;

    //   print("success_cat_pro_req============================view_cart$success");

    //   if (success == 1) {
    //     setState(() {
    //       _isLoggedIn = false;

    //       Navigator.of(context).pushNamed(CategoriesProduct.routeName,
    //           arguments: {
    //             'cat_name': catName,
    //             'cat_slug': alias,
    //             'sub_cat_id': widget.catid
    //           });
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
    final shopCategories =
        Provider.of<ShopCategoriesProvider>(context).shop_categories_items;
    return ModalProgressHUD(
        inAsyncCall: _isLoggedIn,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.themecolor,
        ),
        child: shopCategories.length <= 0
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : GestureDetector(
                onTap: () {
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
                    memberId =
                        Provider.of<UserDetailsProvider>(context, listen: false)
                            .userDetails[0]
                            .memberId
                            .toString()
                            .trim();
                  }
                  // final alias = categories[i].catslug;
                  print("heddddddddddddddddddddddddd");
                  //print(alias);
                  print(uniqueId);
                  print("${branchId}");
                  print("${memberId}");

                  cat_pro_req(widget.catName, widget.slug, uniqueId, branchId,
                      memberId, 1);
                },
                child: Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: GridTile(
                            child: Image.network(
                              widget.catImage,
                              fit: BoxFit.scaleDown,
                            ),
                            footer: GridTileBar(
                              //backgroundColor: Colors.black38,
                              title: Text(
                                "",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )));
  }
}
