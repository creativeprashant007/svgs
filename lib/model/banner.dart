import 'package:flutter/foundation.dart';

class Banner {
  final String bannerId;
  final String bannerImage;
  final String bannerSlug;
  final String bannerSlugType;
  final String catId;
  final String bannerUrl;

  Banner({
    @required this.bannerId,
    @required this.bannerSlug,
    this.catId,
    @required this.bannerSlugType,
    @required this.bannerImage,
    @required this.bannerUrl,
  });
}
