import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/model/static_content/static_content_response.dart';

import 'package:svgs_app/providers/add_address_provider.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/area_provider.dart';
import 'package:svgs_app/providers/banner_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/categories.dart';
import 'package:svgs_app/providers/category_product_listing.dart';
import 'package:svgs_app/providers/checkout_provider.dart';
import 'package:svgs_app/providers/common_provider.dart';
import 'package:svgs_app/providers/login_provider.dart';
import 'package:svgs_app/providers/offers_provider.dart';
import 'package:svgs_app/providers/order_list_provider.dart';
import 'package:svgs_app/providers/placeorder_provider.dart';
import 'package:svgs_app/providers/product_cart_provider.dart';
import 'package:svgs_app/providers/product_details.dart';
import 'package:svgs_app/providers/register_provider.dart';
import 'package:svgs_app/providers/search_products_provider.dart';
import 'package:svgs_app/providers/search_provider.dart';
import 'package:svgs_app/providers/sendOtp_provider.dart';
import 'package:svgs_app/providers/shop_categories_provider.dart';
import 'package:svgs_app/providers/static_page_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/providers/verifymobile_provider.dart';
import 'package:svgs_app/providers/verifyotp_provider.dart';
import 'dart:async';
import 'package:svgs_app/src/item_details.dart';
import 'package:svgs_app/src/logind_signup.dart';
import 'package:svgs_app/src/signup_screen.dart';
import 'package:svgs_app/src/ui/cart/fifth.dart';
import 'package:svgs_app/src/ui/categories/categories_product_list.dart';
import 'package:svgs_app/src/ui/home/first.dart';
import 'package:svgs_app/src/ui/home/homepage.dart';
import 'package:svgs_app/src/ui/home/product_banners_by_slug.dart';

import 'package:svgs_app/src/ui/profile/about_us.dart';
import 'package:svgs_app/src/ui/profile/contact_us.dart';
import 'package:svgs_app/src/ui/profile/delivery_addresses.dart';
import 'package:svgs_app/src/ui/profile/privacy_policy.dart';
import 'package:svgs_app/src/ui/profile/profile_page.dart';
import 'package:svgs_app/src/ui/profile/terms_conditions.dart';
import 'package:svgs_app/src/ui/search/search_product.dart';
import 'package:svgs_app/src/ui/search/second.dart';
import 'package:svgs_app/widgets/checkout/add_new_address.dart';
import 'package:svgs_app/widgets/checkout/order_details.dart';
import 'package:svgs_app/widgets/checkout/order_list.dart';
import 'dart:convert';
import 'dart:developer';
import './providers/top_deal.dart';
import 'package:provider/provider.dart';
import './widgets/home/view_all_top_deal.dart';
import 'firebase/push_notification_service_helper.dart';
import 'helpers/db_area_branch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => TopDealProducts(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryProductListingProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductDetail(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ShopCategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BannerProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ApiProviders(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CheckoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SendOtpProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AreaProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AreaBranchProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => RegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => VerifyMobileProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => VerifyOTPProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CommonProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PlaceOrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AddAddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SearchProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderListProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => StaticPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductCartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OfferProvider(),
        ),
      ],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            primaryColor: AppColors.themecolor,
            primaryColorDark: Colors.white30,
            accentColor: AppColors.themecolor),
        home: new MyHomePage(title: 'SVGS'),
        routes: {
          FirstPage.routeName: (ctx) => FirstPage(),
          Item_Details.routeName: (ctx) => Item_Details(),
          AllTopDealProduct.routeName: (ctx) => AllTopDealProduct(),
          CategoriesProduct.routeName: (ctx) => CategoriesProduct(),
          AddNewAddress.routeName: (ctx) => AddNewAddress(),
          OrderDetails.routeName: (ctx) => OrderDetails(),
          OrderList.routeName: (ctx) => OrderList(),
          SecondPage.routeName: (ctx) => SecondPage(),
          SearchProducts.routeName: (ctx) => SearchProducts(),
          FifthPage.routeName: (ctx) => FifthPage(),
          Login_Screen.routeName: (ctx) => Login_Screen(),
          Signup_Screen.routeName: (ctx) => Signup_Screen(),
          DeliveryAddresses.routeName: (ctx) => DeliveryAddresses(),
          UserProfile.routeName: (ctx) => UserProfile(),
          AboutUs.routeName: (ctx) => AboutUs(),
          PrivacyPolicy.routeName: (ctx) => PrivacyPolicy(),
          TermsCondition.routeName: (ctx) => TermsCondition(),
          ContactUs.routeName: (ctx) => ContactUs(),
          BannerProducts.routeName: (ctx) => BannerProducts(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key); // Testgit init

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _unique_id_gen() async {
    try {
      await Provider.of<ApiProviders>(context, listen: false).uniqueIdApi();
      print("----------------------------------testing");

      final uid = Provider.of<ApiProviders>(context, listen: false).uid;
      print("uniqueId----------------------------------testing$uid");
      final uniqueId = Provider.of<ApiProviders>(context, listen: false)
          .fetchAndSetUniqueId();
      print("uniqueId----------------------------------testing$uniqueId");

      _common_api();
      //startTime();
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  Future<void> _common_api() async {
    try {
      //  Provider.of<CommonProvider>(context).fetchAndSetCommon();

      await Provider.of<CommonProvider>(context, listen: false)
          .fetchAndSetCommon();

      print("----------------------------------testing");

      final android_version =
          Provider.of<CommonProvider>(context, listen: false).android_version;
      final ios_version =
          Provider.of<CommonProvider>(context, listen: false).ios_version;

      print("----------------------------------android_version");
      print(android_version);
      print("----------------------------------ios_version");
      print(ios_version);

      checkLatestVersion(context);

      //startTime();
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 0);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        ModalRoute.withName("/src/homepage"));
  }

  var str_version_and = "0";
  var str_version_ios = "0";
  var str_version = "0";

  checkLatestVersion(context) async {
    await Future.delayed(Duration(seconds: 0));

    //Add query here to get the minimum and latest app version

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    print("packageInfo=========================$packageInfo");

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("ips_appName=========================");
    print(appName);
    print(packageName);
    print(version);
    print(buildNumber);
    print(str_version_and);
    print(str_version_ios);
    print(str_version);
    //print(andr);

    //str_version_and = "2";

    if (Platform.isIOS) {
      if (int.parse(buildNumber) < int.parse(str_version_ios)) {
        _exitApp(context);
        // visible_progress = false;
      } else {
        setState(() {
          startTime();
        });
      }
    } else {
      if (int.parse(buildNumber) < int.parse(str_version_and)) {
        _exitApp(context);
        // visible_progress = false;
      } else {
        setState(() {
          startTime();
        });
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) =>
            WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                title: Text('UPDATE'),
                content: Text('New version is available kindly upgrade now .'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      print("you choose no");
                      Navigator.of(context).pop(false);
                      startTime();
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () {
                      //db.deleteUser1();
                      //Navigator.of(context).pop(false);
                      if (Platform.isIOS) {
                        startTime();
                        //StoreRedirect.redirect(iOSAppId: "1533566690");
                      } else {
                        StoreRedirect.redirect(androidAppId: "svgs.co");
                      }

                      //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false);
  }

  @override
  void initState() {
    super.initState();
    // startTime();
    //startTime();
    pushNotificationService().getToken();
    pushNotificationService().initialize(context);
    print("check unq id ================================== inistate");

    Future.delayed(Duration.zero).then((value) {
      _unique_id_gen();
      //Provider.of<ApiProviders>(context).uniqueIdApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Container(
      //padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset('images/splashscreen.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill),
          )
        ],
      ),
    );
  }
}
