import 'package:flutter/foundation.dart';

class Category_Pro_Model {
  int success;
  int error;
  List<CateDetails> cateDetails;
  List<Product> product;

  Category_Pro_Model(
      {this.success, this.error, this.cateDetails, this.product});

  Category_Pro_Model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['cate_details'] != null) {
      cateDetails = new List<CateDetails>();
      json['cate_details'].forEach((v) {
        cateDetails.add(new CateDetails.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.cateDetails != null) {
      data['cate_details'] = this.cateDetails.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopCategories {
  String catImage;
  String catName;
  String catSlug;
  String catid;

  ShopCategories({
    this.catImage,
    this.catName,
    this.catSlug,
    this.catid,
  });
}

class CateDetails {
  String catid;
  String categoryname;
  String catImage;
  String catslug;
  // ignore: non_constant_identifier_names
  String sub_cat_id;
  String subCatName;
  String subCatSlug;
  bool isExpanded;

  CateDetails({
    this.catid,
    this.categoryname,
    this.catImage,
    this.catslug,
    this.sub_cat_id,
    this.subCatName,
    this.subCatSlug,
    this.isExpanded = false,
  });

  CateDetails.fromJson(Map<String, dynamic> json) {
    catid = json['id1'];
    categoryname = json['categoryname'];
    catslug = json['catslug'];
    sub_cat_id = json['sub_cat_id'];
    subCatName = json['subCatName'];
    subCatSlug = json['parentslug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id1'] = this.catid;
    data['categoryname'] = this.categoryname;
    data['catslug'] = this.catslug;
    data['sub_cat_id'] = this.sub_cat_id;
    data['subCatName'] = this.subCatName;
    data['parentslug'] = this.subCatSlug;
    return data;
  }
}

class SubSubCateDetails {
  String title;
  String alias;
  int id;


  SubSubCateDetails({
    this.title,
    this.alias,
    this.id,
  });

  SubSubCateDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    alias = json['alias'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['alias'] = this.alias;
    data['id'] = this.id;
    return data;
  }
}

class Product {
  String productId;
  String productImage;
  String productName;
  String productSlug;
  String productDescription;
  String productBrand;
  String productItemId;
  String productItems;
  String productItemsSpec;
  String productItemsUnit;
  String productItemsPack;
  String productCatSlug;
  String productItemsStock;
  String productItemsOrginalPrice;
  String productItemsOrginalSellprice;
  String productItemsPrice;
  String productItemsOldPrice;
  String productItemsCoins;
  String productItemsDiscount;
  String productItemsOffer;
  String productItemsOfferType;
  String productItemsOfferMinQty;
  String productItemsOfferMaxQty;
  String productItemsOfferDisc;
  String productItemsOfferDiscPrice;
  String productItemsCartIds;
  String productItemsCartQty;

  Product(
      {this.productId,
      this.productImage,
      this.productName,
      this.productSlug,
      this.productDescription,
      this.productBrand,
      this.productItemId,
      this.productItems,
      this.productItemsSpec,
      this.productItemsUnit,
      this.productItemsPack,
      this.productCatSlug,
      this.productItemsStock,
      this.productItemsOrginalPrice,
      this.productItemsOrginalSellprice,
      this.productItemsPrice,
      this.productItemsOldPrice,
      this.productItemsCoins,
      this.productItemsDiscount,
      this.productItemsOffer,
      this.productItemsOfferType,
      this.productItemsOfferMinQty,
      this.productItemsOfferMaxQty,
      this.productItemsOfferDisc,
      this.productItemsOfferDiscPrice,
      this.productItemsCartIds,
      this.productItemsCartQty});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productImage = json['product_image'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    productBrand = json['product_brand'];
    productItems = json['product_items'];
    productItemsSpec = json['product_items_spec'];
    productItemsUnit = json['product_items_unit'];
    productItemsPack = json['product_items_pack'];
    productItemsStock = json['product_items_stock'];
    productItemsOrginalPrice = json['product_items_orginal_price'];
    productItemsOrginalSellprice = json['product_items_orginal_sellprice'];
    productItemsPrice = json['product_items_price'];
    productItemsOldPrice = json['product_items_old_price'];
    productItemsCoins = json['product_items_coins'];
    productItemsOffer = json['product_items_offer'];
    productItemsOfferType = json['product_items_offer_type'];
    productItemsOfferMinQty = json['product_items_offer_min_qty'];
    productItemsOfferMaxQty = json['product_items_offer_max_qty'];
    productItemsOfferDisc = json['product_items_offer_disc'];
    productItemsOfferDiscPrice = json['product_items_offer_disc_price'];
    productItemsCartIds = json['product_items_cart_ids'];
    productItemsCartQty = json['product_items_cart_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_image'] = this.productImage;
    data['product_name'] = this.productName;
    data['product_slug'] = this.productSlug;
    data['product_brand'] = this.productBrand;
    data['product_items'] = this.productItems;
    data['product_items_spec'] = this.productItemsSpec;
    data['product_items_unit'] = this.productItemsUnit;
    data['product_items_pack'] = this.productItemsPack;
    data['product_items_stock'] = this.productItemsStock;
    data['product_items_orginal_price'] = this.productItemsOrginalPrice;
    data['product_items_orginal_sellprice'] = this.productItemsOrginalSellprice;
    data['product_items_price'] = this.productItemsPrice;
    data['product_items_old_price'] = this.productItemsOldPrice;
    data['product_items_coins'] = this.productItemsCoins;
    data['product_items_offer'] = this.productItemsOffer;
    data['product_items_offer_type'] = this.productItemsOfferType;
    data['product_items_offer_min_qty'] = this.productItemsOfferMinQty;
    data['product_items_offer_max_qty'] = this.productItemsOfferMaxQty;
    data['product_items_offer_disc'] = this.productItemsOfferDisc;
    data['product_items_offer_disc_price'] = this.productItemsOfferDiscPrice;
    data['product_items_cart_ids'] = this.productItemsCartIds;
    data['product_items_cart_qty'] = this.productItemsCartQty;
    return data;
  }
}
