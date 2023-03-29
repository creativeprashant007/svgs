import 'package:flutter/cupertino.dart';
import 'package:svgs_app/model/banner.dart' as banner;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class BannerProvider with ChangeNotifier {
  List<banner.Banner> _bannerItems = [];

  List<banner.Banner> get bannerItems {
    return [..._bannerItems];
  }

  Future<void> fetchAndBanners() async {
    const url = 'https://www.svgs.co/api/banners';
    try {
      final response = await http.get(Uri.parse(url));

      final extractedBanner = json.decode(response.body)['banner'] as List;
      // print(extractedBanner);

      final List<banner.Banner> loadedItem = [];
      extractedBanner.forEach((banners) {
        // print((topDeal['item_sellprice'].split(','))[0]);
        loadedItem.add(banner.Banner(
          bannerId: banners['banner_id'].toString(),
          bannerImage: banners['banner_image'],
          bannerSlug: banners['banner_slug'],
          catId: banners['cat_id'].toString(),
          bannerSlugType: banners['banner_type'],
          bannerUrl: banners['banner_url'],
        ));
        _bannerItems = loadedItem;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  List<banner.Banner> _offerItems = [];

  List<banner.Banner> get offerItems {
    return [..._offerItems];
  }

  Future<void> fetchOffers() async {
    const url = 'https://www.svgs.co/api/banners';
    try {
      final response = await http.get(Uri.parse(url));

      final extractedBanner = json.decode(response.body)['bannerOffer'] as List;
      // print(extractedBanner);

      final List<banner.Banner> loadedItem = [];
      extractedBanner.forEach((banners) {
        // print((topDeal['item_sellprice'].split(','))[0]);
        loadedItem.add(banner.Banner(
          bannerId: banners['banner_id'].toString(),
          bannerImage: banners['banner_image'],
          bannerSlug: banners['banner_slug'],
          catId: banners['cat_id'].toString(),
          bannerSlugType: banners['banner_type'],
          bannerUrl: banners['banner_url'],
        ));
        _offerItems = loadedItem;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }
}
