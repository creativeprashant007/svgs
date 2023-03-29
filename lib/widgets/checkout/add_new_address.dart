import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/IDClass.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/add_address_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/widgets/sheet/showpage.dart';

class AddNewAddress extends StatefulWidget {
  static const routeName = '/add-new-address';

  AddNewAddress(
      {this.from_key,
      this.ship_id,
      this.shipName,
      this.shipMobile,
      this.shipAddress,
      this.shipPinCode,
      this.shipLandmark,
      this.shipCity,
      this.shipAreaId,
      this.shipArea});

  final String from_key;
  final String ship_id;

  final String shipName;
  final String shipMobile;
  final String shipAddress;

  final String shipAreaId;
  final String shipArea;

  final String shipPinCode;
  final String shipLandmark;
  final String shipCity;

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final _mobileFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _postCodeFocusNode = FocusNode();
  final _areaIdFocusNode = FocusNode();
  final _areaFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _landMarkFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();

  String nName = "";
  String nMobile = "";
  String nAddress = "";

  TextEditingController etName = new TextEditingController();
  TextEditingController etMobile = new TextEditingController();
  TextEditingController etAddress = new TextEditingController();
  TextEditingController etLandMark = new TextEditingController();
  TextEditingController etCity = new TextEditingController();

  String nPincode = "";
  String postcode = "";
  String area_id = "";
  String area = "";

  String nLandMark = "";
  String nCity = "";
  String nCountry = "";
  bool _isLoggedIn = false;

  TextEditingController etcountry = new TextEditingController();
  TextEditingController etarea = new TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      if (widget.from_key == 'edit') {
        etName.text = widget.shipName;
        etMobile.text = widget.shipMobile;
        etAddress.text = widget.shipAddress;

        etarea.text = widget.shipPinCode;

        if (widget.shipLandmark != null) {
          if (widget.shipLandmark != "") {
            if (widget.shipLandmark != "null") {
              etLandMark.text = widget.shipLandmark;
            } else {
              etLandMark.text = "";
            }
            //etLandMark.text = widget.shipLandmark;
          } else {
            etLandMark.text = "";
          }
        } else {
          etLandMark.text = "";
        }

        if (widget.shipCity != null) {
          if (widget.shipCity != "") {
            if (widget.shipCity != "null") {
              etCity.text = widget.shipCity;
            } else {
              etCity.text = "";
            }
          } else {
            etCity.text = "";
          }
        } else {
          etCity.text = "";
        }

        postcode = widget.shipPinCode;
        area_id = widget.shipAreaId;
        area = widget.shipArea;
        nPincode = widget.shipPinCode;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _mobileFocusNode.dispose();
    _addressFocusNode.dispose();
    _postCodeFocusNode.dispose();
    _areaIdFocusNode.dispose();
    _areaFocusNode.dispose();
    _stateFocusNode.dispose();
    _cityFocusNode.dispose();
    _landMarkFocusNode.dispose();
    _countryFocusNode.dispose();
    super.dispose();
  }

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

  String validateName(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter the name.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    //if (value.length != 10) return 'Enter valid mobile number.';
    return null;
  }

  String validateMobile(String value) {
    //_formWasEdited = tvrue;
    if (value.isEmpty) return 'Enter mobile number.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value.length != 10) return 'Enter valid mobile number.';
    return null;
  }

  String validateAddress(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter the address.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    //if (value.length != 10) return 'Enter valid mobile number.';
    return null;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String str_content = '';
  Future<void> _submit(
      String mem_id,
      String nName,
      String nMobile,
      String nAddress,
      String postcode,
      String area_id,
      String area,
      String nCity,
      String nLandMark) async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      print("o9o9o9o9o9o9o9o9o9o9");
      print(nPincode);

      if (nPincode != "") {
        try {
          setState(() {
            _isLoggedIn = true;
          });

          if (widget.from_key == 'edit') {
            await Provider.of<AddAddressProvider>(context, listen: false)
                .fetchAndSetAddAddress(mem_id, nName, nMobile, nAddress,
                    postcode, area_id, area, nCity, nLandMark, widget.ship_id);
          } else {
            await Provider.of<AddAddressProvider>(context, listen: false)
                .fetchAndSetAddAddress(mem_id, nName, nMobile, nAddress,
                    postcode, area_id, area, nCity, nLandMark, widget.ship_id);
          }

          print("Login---------------------------------testing");

          String success =
              Provider.of<AddAddressProvider>(context, listen: false)
                  .success
                  .toString();
          final error =
              Provider.of<AddAddressProvider>(context, listen: false).error;

          if (success == '1') {
            final message =
                Provider.of<AddAddressProvider>(context, listen: false).message;
            print("success=================================$success");

            setState(() {
              _isLoggedIn = false;
              var str_v = message.toString();
              alert_snack_login(str_v);
              Navigator.of(context).pop();
            });
          } else {
            setState(() {
              _isLoggedIn = false;
              var str_v = "Already existing adddress";
              alert_snack_login(str_v);
            });
          }
        } catch (error) {
          setState(() {
            _isLoggedIn = false;
          });

          print("----------------------------------$error");
          throw error;
        }
      } else {
        str_content = "Select your Post Code.";
        alert_snack_login(str_content);
      }
    }
    // ---- Login
    print("reg_url_code-------------------------------");
  }

  void alert_snack_login(String str_content) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(str_content),
      duration: Duration(seconds: 3),
    ));
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
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

        nName = etName.text.toString();
        nMobile = etMobile.text.toString();
        nAddress = etAddress.text.toString();

        nCity = etCity.text.toString();
        nLandMark = etLandMark.text.toString();

        print("99999999999999999999999999999998");
        print(nName);
        print(nMobile);
        print(nAddress);
        print(postcode);
        print(area_id);
        print(area);
        print(nCity);
        print(nLandMark);

        _submit(mem_id, nName, nMobile, nAddress, postcode, area_id, area,
            nCity, nLandMark);

        /*showDialog(
            context: context,
            barrierDismissible: false,
            builder: ((BuildContext context) {
              return DynamicDialog(id:"id",number:"number",mob_v:"mob_v",otp:"otp".toString());
            }));*/
        print("testing_messurement");
      },
      child: Container(
        width: 120.0,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF694489),
                  Color(0xFF694489),
                  Color(0xFF694489)
                ])),
        //colors: [Color(0xFF28a745), Color(0xFF28a745), Color(0xFF28a745)])),
        child: Text(
          "Save",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  opensheet() async {
    print("444444444444444444444444444444444");
    var from_page = "ShipAdd";
    showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            // context: (context),
            // enableDrag: true,
            // isDismissible: true,
            builder: (context) => new ShowModalPage(from_page: from_page))
        .then((value) {
      setState(() {
        print("ooooooooooooooooooooooooooooooooooo8989");
        print(IDCardClass.area_name);
        if (!IDCardClass.area_name.isEmpty) {
          nPincode = IDCardClass.area_name.toString() +
              "/" +
              IDCardClass.area_pin.toString();

          postcode = IDCardClass.area_pin.toString();
          area_id = IDCardClass.area_id.toString();
          area = IDCardClass.area_name.toString();
          etarea.text = nPincode;
          etCity.text = IDCardClass.area_city.toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    etcountry.text = 'India';
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.themecolor,
        leading: IconButton(
            icon: Icon(
              _backIcon(),
              color: AppColors.whiteColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Add New Address',
          style: TextStyles.actionTitle_w,
        ),
        actions: [
          /*IconButton(icon: Icon(Icons.save), onPressed: () {}),*/
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: ModalProgressHUD(
            inAsyncCall: _isLoggedIn,
            child: Form(
              key: formKey,
              child: Theme(
                data: new ThemeData(
                  primaryColor: AppColors.gr_start,
                  primaryColorDark: AppColors.gr_end,
                ),
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: AppColors.gr_start)),
                        hintText: 'Enter Name',
                        /* helperText: 'Keep it short, this is just a demo.',*/
                        labelText: 'Name',
                        /*prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.gr_start,
                    ),*/
                      ),
                      //hintText: "Enabled decoration text ...",
                      textInputAction: TextInputAction.next,
                      validator: validateName,
                      controller: etName,
                      /*onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_mobileFocusNode);
                  },*/
                      onSaved: (String val) {
                        nName = val;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: AppColors.gr_start)),
                        hintText: 'Enter Mobile Number',
                        /* helperText: 'Keep it short, this is just a demo.',*/
                        labelText: 'Mobile Number',
                        /*prefixIcon: const Icon(
                      Icons.phone_iphone,
                      color: AppColors.gr_start,
                    ),*/
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      controller: etMobile,
                      //focusNode: _mobileFocusNode,
                      validator: validateMobile,
                      /*onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_addressFocusNode);
                  },*/
                      onSaved: (String val) {
                        nMobile = val;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: AppColors.gr_start)),
                        hintText: 'Enter Address',
                        /* helperText: 'Keep it short, this is just a demo.',*/
                        labelText: 'Address',
                        /*prefixIcon: const Icon(
                      Icons.location_city,
                      color: AppColors.gr_start,
                    ),*/
                      ),
                      //focusNode: _addressFocusNode,
                      validator: validateAddress,
                      maxLines: 2,
                      controller: etAddress,
                      keyboardType: TextInputType.multiline,
                      onSaved: (String val) {
                        nAddress = val;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        print("I'm here!!!");
                        setState(() {
                          // _settingModalBottomSheet();
                          opensheet();
                          //etarea.text = "My Stringt";
                        });
                      },
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: AppColors.gr_start)),
                          hintText: 'Enter Post Code',
                          /* helperText: 'Keep it short, this is just a demo.',*/
                          labelText: 'Post Code',
                          /*prefixIcon: const Icon(
                      Icons.post_add,
                      color: AppColors.gr_start,
                    ),*/
                        ),
                        enabled: false,
                        showCursor: false,
                        readOnly: true,
                        controller: etarea,
                        //focusNode: _postCodeFocusNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        /* onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_areaIdFocusNode);
                    },*/
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: AppColors.gr_start)),
                        hintText: 'Enter LandMark',
                        /* helperText: 'Keep it short, this is just a demo.',*/
                        labelText: 'LandMark (Optional)',
                        /* prefixIcon: const Icon(
                      Icons.place,
                      color: AppColors.gr_start,
                    ),*/
                      ),
                      //focusNode: _landMarkFocusNode,
                      textInputAction: TextInputAction.next,
                      /*onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_countryFocusNode);
                  },*/
                      controller: etLandMark,
                      onSaved: (String val) {
                        nLandMark = val;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: AppColors.gr_start)),
                        hintText: 'Enter City',
                        /* helperText: 'Keep it short, this is just a demo.',*/
                        labelText: 'City',
                        /* prefixIcon: const Icon(
                      Icons.location_city_rounded,
                      color: AppColors.gr_start,
                    ),*/
                      ),
                      //focusNode: _cityFocusNode,
                      textInputAction: TextInputAction.next,
                      /*onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_landMarkFocusNode);
                  },*/
                      enabled: false,
                      showCursor: false,
                      readOnly: true,
                      controller: etCity,
                      onSaved: (String val) {
                        nCity = val;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: AppColors.gr_start)),
                        hintText: 'Enter Country',
                        /* helperText: 'Keep it short, this is just a demo.',*/
                        labelText: 'Country',
                        /*  prefixIcon: const Icon(
                      Icons.place,
                      color: AppColors.gr_start,
                    ),*/
                      ),
                      controller: etcountry,
                      enabled: false,
                      showCursor: false,
                      readOnly: true,
                      //focusNode: _countryFocusNode,
                      textInputAction: TextInputAction.next,
                      onSaved: (String val) {
                        nCountry = val;
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    _submitButton()
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
