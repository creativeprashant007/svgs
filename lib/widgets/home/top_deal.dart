import 'package:flutter/material.dart';
import 'package:svgs_app/providers/top_deal.dart';
import 'package:svgs_app/widgets/simmer/featured_product_simmer.dart';
import './widgets.dart';
import 'package:provider/provider.dart';

class TopDeal extends StatefulWidget {
  @override
  _TopDealState createState() => _TopDealState();
}

class _TopDealState extends State<TopDeal> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final topDealData = Provider.of<TopDealProducts>(context);
    final topDealProduct = topDealData.top_deal_items;

    return topDealProduct.length == 0
        ? FeaturedProductListSimmer()
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, i) {
              return TopDealProduct(
                itemId: topDealProduct[i].productItemId,
                productId: topDealProduct[i].productId,
                productName: topDealProduct[i].productName,
                productImage: topDealProduct[i].productImage,
                productPrice: topDealProduct[i].productItemsOrginalSellprice,
                productOldPrice: topDealProduct[i].productItemsOldPrice,
                productSavePrice: topDealProduct[i].productItemsDiscount,
                productSlug: topDealProduct[i].productSlug,
                productSpec: topDealProduct[i].productItemsSpec,
                productUnit: topDealProduct[i].productItemsUnit,
                notifyParent: refresh,
              );
            },
            itemCount: topDealProduct.length,
          );
  }
}
