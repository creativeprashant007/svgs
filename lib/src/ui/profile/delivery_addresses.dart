import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/checkout_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/widgets/checkout/add_new_address.dart';

import 'address_items.dart';

class DeliveryAddresses extends StatefulWidget {
  static const routeName = '/delivery-addresses';
  @override
  _DeliveryAddressesState createState() => _DeliveryAddressesState();
}

class _DeliveryAddressesState extends State<DeliveryAddresses> {
  bool _hide_delete_ic = false;
  List address_dynamic = [];
  bool _isLoggedIn = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      if (Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      ).userDetails.isEmpty) {
      } else {
        final member = Provider.of<UserDetailsProvider>(
          context,
          listen: false,
        ).userDetails[0];

        shipping_addres(member.memberId);
        /* Provider.of<CheckoutProvider>(context)
            .fetchAndSetDeliveryAddress(member.memberId);*/
      }
    });
    super.initState();
  }

  Future<void> shipping_addres(String mem_id) async {
    print("checking==================date_res");

    try {
      await Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).fetchAndSetDeliveryAddress(mem_id);

      /*if(!add_pos.isEmpty){
        add_pos.clear();
      }*/

      if (!address_dynamic.isEmpty) {
        address_dynamic.clear();
      }

      if (!Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).addresses.isEmpty) {
        setState(() {
          address_dynamic = Provider.of<CheckoutProvider>(
            context,
            listen: false,
          ).addresses;
          if (Provider.of<CheckoutProvider>(
                context,
                listen: false,
              ).addresses.length ==
              1) {
            _hide_delete_ic = false;
          } else {
            _hide_delete_ic = true;
          }
        });

        print("oooooooooooooooooooooooooooooooooo");
        print(Provider.of<CheckoutProvider>(
          context,
          listen: false,
        ).addresses.length);
      }

      print("checking_vera_level============================view_cartddd");
      //print("checking_vera_level============================view_cart$dates_pos");

      print(address_dynamic);
      //  print(dates);

    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  // deleted address -----------------------
  Future<void> remove_address(String ship_id) async {
    print("checking==================date_res");

    setState(() {
      _isLoggedIn = true;
    });

    try {
      await Provider.of<CheckoutProvider>(
        context,
        listen: false,
      ).fetchAndRemoveAddress(ship_id);

      if (Provider.of<CheckoutProvider>(
            context,
            listen: false,
          ).success ==
          1) {
        final userDetails = Provider.of<UserDetailsProvider>(
          context,
          listen: false,
        ).userDetails;
        String mem_id;
        if (userDetails.isEmpty) {
          mem_id = '';
        } else {
          mem_id = Provider.of<UserDetailsProvider>(
            context,
            listen: false,
          ).userDetails[0].memberId.toString().trim();
        }
        shipping_addres(mem_id);
      }

      print("date____________________removed");

      setState(() {
        _isLoggedIn = false;
      });
    } catch (error) {
      print("----------------------------------$error");
      throw (error);
    }
  }

  Widget address_grid(int pos) {
    String name = address_dynamic[pos].shipName.toString();
    String mobile = address_dynamic[pos].shipMobile.toString();
    String areaId = address_dynamic[pos].shipAreaId.toString();
    String address = address_dynamic[pos].shipAddress.toString();
    String landMark = address_dynamic[pos].shipLandmark.toString();
    String pincode = address_dynamic[pos].shipPinCode.toString();
    String state = address_dynamic[pos].shipState.toString();
    String city = address_dynamic[pos].shipCity.toString();

    String land_mark = landMark;
    String city_ = city;

    if (land_mark != null) {
      if (land_mark != "") {
        if (land_mark != "null") {
          land_mark = landMark;
        } else {
          land_mark = "";
        }
      } else {
        land_mark = "";
      }
    } else {
      land_mark = "";
    }

    if (city_ != null) {
      if (city_ != "") {
        if (city_ != "null") {
          city_ = city;
        } else {
          city_ = "";
        }
      } else {
        city_ = "";
      }
    } else {
      city_ = "";
    }

    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: AppColors.themecolor,
          border: Border.all(
            color: AppColors.themecolor,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${name}',
              style: TextStyles.subText_w,
            ),
            Text(
              '${mobile}',
              style: TextStyles.subText_w,
            ),
            Text(
              '${address}',
              style: TextStyles.subText_w,
            ),
            Text(
              '${land_mark}${city_}',
              style: TextStyles.subText_w,
            ),
            Text(
              '${state}',
              style: TextStyles.subText_w,
            ),
            Text(
              '${pincode}',
              style: TextStyles.subText_w,
            ),
            Expanded(
                child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      String shipping_id = address_dynamic[pos].id.toString();

                      print(
                          "deleted ===================================== source");
                      print(shipping_id);

                      remove_address(shipping_id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Container(
                      child: Center(
                          child: InkWell(
                              onTap: () {
                                String shipping_id =
                                    address_dynamic[pos].id.toString();
                                String shipName =
                                    address_dynamic[pos].shipName.toString();
                                String shipMobile =
                                    address_dynamic[pos].shipMobile.toString();

                                String shipAddress =
                                    address_dynamic[pos].shipAddress.toString();

                                String shipPinCode =
                                    address_dynamic[pos].shipPinCode.toString();
                                String shipLandmark = address_dynamic[pos]
                                    .shipLandmark
                                    .toString();
                                String shipCity =
                                    address_dynamic[pos].shipCity.toString();

                                String shipAreaId =
                                    address_dynamic[pos].shipAreaId.toString();
                                String shipArea =
                                    address_dynamic[pos].shipArea.toString();

                                print("5555555555555555555555555");
                                print(shipName);
                                print(shipLandmark);
                                print(shipCity);

                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new AddNewAddress(
                                          from_key: "edit",
                                          ship_id: shipping_id,
                                          shipName: shipName,
                                          shipMobile: shipMobile,
                                          shipAddress: shipAddress,
                                          shipPinCode: shipPinCode,
                                          shipLandmark: shipLandmark,
                                          shipCity: shipCity,
                                          shipAreaId: shipAreaId,
                                          shipArea: shipArea)),
                                ).then((value) {
                                  setState(() {
                                    final userDetails =
                                        Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userDetails;
                                    String mem_id;
                                    if (userDetails.isEmpty) {
                                      mem_id = '';
                                    } else {
                                      mem_id = Provider.of<UserDetailsProvider>(
                                              context,
                                              listen: false)
                                          .userDetails[0]
                                          .memberId
                                          .toString()
                                          .trim();
                                    }
                                    shipping_addres(mem_id);
                                  });
                                });
                              },
                              child: Icon(
                                Icons.edit_outlined,
                                color: AppColors.whiteColor,
                              ))))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deliveryAddresses = Provider.of<CheckoutProvider>(context).addresses;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: AppColors.themecolor,
        title: Text(
          'Delivery Addresses',
          style: TextStyles.actionTitle_w,
        ),
      ),
      body: ModalProgressHUD(
          inAsyncCall: _isLoggedIn,
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.themecolor,
                              borderRadius: BorderRadius.circular(
                                10.0,
                              )),
                          margin: const EdgeInsets.all(20.0),
                          child: FlatButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                              10.0,
                            )),
                            color: AppColors.themecolor,
                            onPressed: () {
                              /*Navigator.of(context).pushNamed(AddNewAddress.routeName);*/

                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new AddNewAddress(
                                        from_key: 'delivery', ship_id: "0")),
                              ).then((value) {
                                setState(() {
                                  final userDetails =
                                      Provider.of<UserDetailsProvider>(context)
                                          .userDetails;
                                  String mem_id;
                                  if (userDetails.isEmpty) {
                                    mem_id = '';
                                  } else {
                                    mem_id = Provider.of<UserDetailsProvider>(
                                            context)
                                        .userDetails[0]
                                        .memberId
                                        .toString()
                                        .trim();
                                  }
                                  shipping_addres(mem_id);
                                });
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Add New Address',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        /// addresses
                        ///
                      ],
                    ),
                    //////address============
                    address_dynamic.length == 0
                        ? Container(
                            height: 230.0,
                            child: Center(child: CircularProgressIndicator()))
                        : Container(
                            height: 230.0 * address_dynamic.length,
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              //padding: const EdgeInsets.all(5.0),
                              itemCount: address_dynamic.length,
                              itemBuilder: (c, i) {
                                return address_grid(i);
                                /*  return AddressItem(
                          areaId: address_dynamic[i].shipAreaId,
                          address: address_dynamic[i].shipAddress,
                          landMark: address_dynamic[i].shipLandmark,
                          pincode: address_dynamic[i].shipPinCode,
                          state: address_dynamic[i].shipState,
                        );*/
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      //    childAspectRatio: 5 / 4,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0),
                            ),
                          ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
