import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/product_details.dart';
import 'package:svgs_app/providers/search_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/ui/home/homepage.dart';
import 'package:svgs_app/src/ui/search/search_product.dart';

import '../../item_details.dart';

class SecondPage extends StatefulWidget {
  static const routeName = '/search';
  final String data;

  const SecondPage({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final myController_search = TextEditingController();
  bool _isProgress = false;
  final _textFocus = new FocusNode();
  List search_product = [];
  int _pageNumber = 1;
  String search_name = "";
  bool prgress_bar = false;

  ScrollController _scrollController = ScrollController();
  //List<Map<String,dynamic>> loadedProduct = [];

  Future<void> _submit_product_name(String pattern) async {
    // final form = formKey.currentState;
    //   form.save();

    // ---- pattern
    String memberId;
    if (Provider.of<UserDetailsProvider>(context, listen: false)
        .userDetails
        .isEmpty) {
      memberId = '';
    } else {
      memberId = Provider.of<UserDetailsProvider>(context, listen: false)
          .userDetails[0]
          .memberId;
    }
    print('hello');
    final uniqueId = Provider.of<ApiProviders>(context, listen: false).uid;
    print(uniqueId);

    final branchId =
        Provider.of<AreaBranchProvider>(context, listen: false).branch_id_v;
    print("pattern-------------------------------");
    print(pattern);

    try {
      setState(() {
        if (_pageNumber == 1) {
          _isProgress = true;
        }
      });
      await Provider.of<SearchProvider>(context, listen: false)
          .fetchAndSetSearchItem(
              branchId, pattern, uniqueId, memberId, _pageNumber);

      print("SearchProvider---------------------------------testing");

      final products =
          Provider.of<SearchProvider>(context, listen: false).searchItem;

      final int_last_page =
          Provider.of<SearchProvider>(context, listen: false).last_page;
      print("int_last_page---------------------------------int_last_page");
      print(int_last_page);

      if (_pageNumber <= int_last_page) {
        if (!products.isEmpty) {
          //final otp = Provider.of<SendOtpProvider>(context).otp;
          print("products=================================#############");
          print(products[0].productName);

          setState(() {
            /*if (!search_product.isEmpty) {
            search_product.clear();
          }*/

            for (int i = 0; i < products.length; i++) {
              Map<String, String> map = new Map<String, String>();
              map['id'] = products[i].productId;
              map['product_slug'] = products[i].productSlug;
              map['product_name'] = products[i].productName;

              search_product.add(map);
            }

            print(
                "_isProgress=================================$search_product");
            if (_pageNumber == 1) {
              _isProgress = false;
            } else {
              prgress_bar = false;
            }
          });
        } else {
          setState(() {
            if (_pageNumber == 1) {
              _isProgress = false;
            } else {
              prgress_bar = false;
            }
          });
        }
      } else {
        setState(() {
          if (_pageNumber == 1) {
            _isProgress = false;
          } else {
            prgress_bar = false;
          }
        });
      }
    } catch (error) {
      if (_pageNumber == 1) {
        _isProgress = false;
      } else {
        prgress_bar = false;
      }

      print("----------------------------------$error");
      throw error;
    }
  }

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

    //   await Provider.of<SearchProvider>(
    //     context,
    //     listen: false,
    //   ).fetchAndSetSearchItem(
    //       prodPattern, uniqueId, branchId, memberId, _pageNumber);

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
  // ----------------------------------------------------------------------------------------------------

  bool _isLoggedIn = false;

  IconData _backIcon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {});

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
            Provider.of<SearchProvider>(context, listen: false).last_page;

        print('json___________________pack------------------------');
        print(int_last_page);

        if (_pageNumber <= int_last_page) {
          _submit_product_name(search_name);
          //_getMoreData(_pageNumber);
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

  @override
  Widget build(BuildContext context) {
    //final padding = MediaQuery.of(context).padding.top;
    String backButton;
    if (widget.data == 'notback') {
    } else {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      backButton = routeArgs['back'];
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        backgroundColor: AppColors.themecolor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Search',
          style: TextStyles.actionTitle_w,
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                color: AppColors.themecolor,
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.themecolor),
                      borderRadius: BorderRadius.circular(
                        5.0,
                      )),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Theme(
                    data: new ThemeData(
                        // primaryColor: Colors.black,
                        // primaryColorDark: Colors.red,
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            autofocus: true,
                            controller: myController_search,
                            focusNode: _textFocus,
                            onChanged: (text) {
                              if (text.length >= 3) {
                                setState(() {
                                  _isProgress = true;
                                  if (!search_product.isEmpty) {
                                    search_product.clear();
                                  }
                                  search_name = text.toString().trim();
                                  _pageNumber = 1;
                                  _submit_product_name(text.toString().trim());
                                });
                              } else {
                                setState(() {
                                  if (!search_product.isEmpty) {
                                    search_product.clear();
                                  }
                                  _isProgress = false;
                                });
                              }
                              print("First text field: $text");
                              print("First text field: $myController_search");
                            },
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter 3 or more characters',
                              prefixIcon: const Icon(
                                Icons.local_grocery_store,
                                color: Colors.grey,
                                size: 25.0,
                              ),
                              prefixText: ' ',
                              suffixText: '',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('i am here');
                            final productPattern =
                                myController_search.text.toString().trim();

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
                                      listen: false)
                                  .userDetails[0]
                                  .memberId
                                  .toString()
                                  .trim();
                            }

                            print('------------i am here');
                            if (search_product.length > 1)
                              search_products_req(
                                  productPattern, uniqueId, branchId, memberId);
                          },
                          child: _isLoggedIn
                              ? Container(
                                  height: 20.0,
                                  width: 20.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    color: AppColors.themecolor,
                                  ))
                              : Container(
                                  //padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 25.0,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: _isProgress,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: 30,
              width: 30,
              child: new Center(
                child: new CircularProgressIndicator(
                  color: AppColors.themecolor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ListView.separated(
                controller: _scrollController,
                itemCount: search_product.length,
                separatorBuilder: (_, __) => Divider(height: 0.5),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(search_product[index]['product_name'] != null
                        ? search_product[index]['product_name']
                        : ""),
                    // subtitle: Text(search_product[index]['product_name'] != null
                    //     ? search_product[index]['product_name']
                    //     : ""),
                    trailing: Icon(Icons.arrow_forward_ios),
                    isThreeLine: false,
                    onTap: () {
                      String memberId;
                      if (Provider.of<UserDetailsProvider>(context,
                              listen: false)
                          .userDetails
                          .isEmpty) {
                        memberId = '';
                      } else {
                        memberId = Provider.of<UserDetailsProvider>(context,
                                listen: false)
                            .userDetails[0]
                            .memberId;
                      }
                      print('hello');
                      final uniqueId =
                          Provider.of<ApiProviders>(context, listen: false).uid;
                      print(uniqueId);

                      final branchId = Provider.of<AreaBranchProvider>(context,
                              listen: false)
                          .branch_id_v;
                      Provider.of<ProductDetail>(context, listen: false)
                          .fetchAndSetProductDetail(
                              search_product[index]['product_slug'].toString(),
                              uniqueId,
                              branchId,
                              memberId);
                      Navigator.of(context)
                          .pushNamed(Item_Details.routeName, arguments: {
                        'product_name':
                            search_product[index]['product_name'].toString(),
                        'product_slug':
                            search_product[index]['product_slug'].toString(),
                      });
                    },
                  );
                },
              ),
            ),
          ),
          Visibility(
              visible: prgress_bar,
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 20,
                      width: 20,
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      child: CircularProgressIndicator(
                        color: AppColors.themecolor,
                        strokeWidth: 2,
                      )))),
        ],
      ),
    );
  }
}
