import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/src/ui/cart/fifth.dart';
import 'package:svgs_app/widgets/home/product_listing.dart';
import 'package:svgs_app/widgets/simmer/product_list_simmer.dart';
import '../../providers/top_deal.dart';
import '../badge.dart';

class AllTopDealProduct extends StatelessWidget {
  static const routeName = '/all-top-deal-product';
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<TopDealProducts>(context).top_deal_items;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.themecolor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Featured Products', style: TextStyles.actionTitle_w),
        actions: <Widget>[
          Consumer<CartProvider>(
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: AppColors.whiteColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  FifthPage.routeName,
                  arguments: {
                    'key': 'back',
                  },
                );
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
      body: loadedProduct.length <= 1
          ? ProductListSimmer()
          : ListView.builder(
              //padding: const EdgeInsets.all(5.0),
              itemCount: loadedProduct.length,
              itemBuilder: (c, i) {
                return Column(
                  children: [
                    ProductListing(
                      itemId: loadedProduct[i].productItemId,
                      productId: loadedProduct[i].productId,
                      productName: loadedProduct[i].productName,
                      productImage: loadedProduct[i].productImage,
                      productPrice:
                          loadedProduct[i].productItemsOrginalSellprice,
                      productOldPrice: loadedProduct[i].productItemsOldPrice,
                      productSavePrice: loadedProduct[i].productItemsDiscount,
                      productSlug: loadedProduct[i].productSlug,
                      productSpec: loadedProduct[i].productItemsSpec,
                      productUnit: loadedProduct[i].productItemsUnit,
                    ),
                    Divider(),
                  ],
                );
              },
            ),
    );
  }
}
