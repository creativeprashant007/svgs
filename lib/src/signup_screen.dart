import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/IDClass.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/constants/textstyles.dart';

import 'package:svgs_app/providers/register_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/providers/verifymobile_provider.dart';
import 'package:svgs_app/src/logind_signup.dart';
import 'package:flutter/material.dart';
import 'package:svgs_app/widgets/sheet/showpage.dart';
import 'package:svgs_app/widgets/showalert.dart';

class Signup_Screen extends StatefulWidget {
  @override
  static const routeName = '/sign-up';
  State<StatefulWidget> createState() => signup();
}

class signup extends State<Signup_Screen> with WidgetsBindingObserver {
  /* void randomMSG() {

    print('Second Class Function Called.');
    print(IDCardClass.area_pincode_v);


    setState(() {
      area_pincode = IDCardClass.area_pincode_v+"/"+IDCardClass.area_pincode_v;
      etarea.text = area_pincode;
    });



  }
*/
  FocusNode myFocusNode;
  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List data_area_pin = [];

  String _email;
  String _password;
  String area_pincode = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  bool _formWasEdited = false;
  bool _showOTP = false;
  bool _isInAsyncCall = false;
  bool _isLoggedIn = false;
  bool _isProgress = false;
  var _sOtp = "SingUp";
  bool _showPassword = false;

  TextEditingController etFirstName = new TextEditingController();
  TextEditingController etLastName = new TextEditingController();
  TextEditingController etEmail = new TextEditingController();
  TextEditingController etPhone = new TextEditingController();
  TextEditingController etaddress = new TextEditingController();
  TextEditingController etpassword = new TextEditingController();
  TextEditingController etarea = new TextEditingController();
  TextEditingController etarea_pincode = new TextEditingController();

  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity;
  final myController_search_loc = TextEditingController();
  final _textFocus = new FocusNode();

  String nName = "";
  String nEmail = "";
  String nPhoneNumber = "";
  String nMobilenumber = "";
  String nAddress = "";
  String nPassord = "";
  String nArea_id = "";
  String nArea = "";

  String nOtp = "";
  String str_Otp = "";
  var str_content = "";

  String validateName(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter Name.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    return null;
  }

  String validateEmail(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter Email id.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (EmailValidator.validate(value)) {
    } else {
      return 'Enter valid email id.';
    }

    return null;
  }

  String validateMobile(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter mobile number.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value.length != 10) return 'Enter valid mobile number.';
    return null;
  }

  String validateAddress(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter address.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    return null;
  }

  String validatePassword(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter password.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    return null;
  }

  String validatePincode(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Select your area name or pincode.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    return null;
  }

  Widget _editText() {
    return Column(
      children: <Widget>[
        new Theme(
          data: new ThemeData(
            primaryColor: AppColors.themecolor,
            primaryColorDark: AppColors.themecolor,
          ),
          child: new TextFormField(
            controller: etFirstName,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: AppColors.themecolor)),
              hintText: 'Enter name',
              /* helperText: 'Keep it short, this is just a demo.',*/
              labelText: 'Name',
            ),
            validator: validateName,
            onSaved: (String val) {
              nName = val;
            },
          ),
        ),
        SizedBox(height: 16),
        new Theme(
          data: new ThemeData(
            primaryColor: AppColors.themecolor,
            primaryColorDark: AppColors.themecolor,
          ),
          child: new TextFormField(
            controller: etEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: AppColors.themecolor)),
              hintText: 'Enter email',
              /* helperText: 'Keep it short, this is just a demo.',*/
              labelText: 'Email',
            ),
            validator: validateEmail,
            onSaved: (String val) {
              nEmail = val;
            },
          ),
        ),
        SizedBox(height: 16),
        new Theme(
          data: new ThemeData(
            primaryColor: AppColors.themecolor,
            primaryColorDark: AppColors.themecolor,
          ),
          child: new TextFormField(
            controller: etPhone,
            maxLength: 10,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: AppColors.themecolor)),
              hintText: 'Enter phone',
              /* helperText: 'Keep it short, this is just a demo.',*/
              labelText: 'Phone',
            ),
            validator: validateMobile,
            onSaved: (String val) {
              nPhoneNumber = val;
            },
          ),
        ),
        SizedBox(height: 16),
        new Theme(
          data: new ThemeData(
            primaryColor: AppColors.themecolor,
            primaryColorDark: AppColors.themecolor,
          ),
          child: new TextFormField(
            controller: etaddress,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: AppColors.themecolor)),
              hintText: 'Enter address',
              /* helperText: 'Keep it short, this is just a demo.',*/
              labelText: 'Address',
            ),
            validator: validateAddress,
            onSaved: (String val) {
              nAddress = val;
            },
          ),
        ),
        SizedBox(height: 16),
        new Theme(
          data: new ThemeData(
            primaryColor: AppColors.themecolor,
            primaryColorDark: AppColors.themecolor,
          ),
          child: new TextFormField(
            controller: etpassword,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: AppColors.themecolor)),
              hintText: 'Enter password',
              /* helperText: 'Keep it short, this is just a demo.',*/
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color:
                      this._showPassword ? AppColors.themecolor : Colors.grey,
                ),
                onPressed: () {
                  setState(() => this._showPassword = !this._showPassword);
                },
              ),
            ),
            validator: validatePassword,
            onSaved: (String val) {
              nPassord = val;
            },
          ),
        ),
        SizedBox(height: 16),
        InkWell(
          onTap: () {
            print("I'm here!!!");
            setState(() {
              // _settingModalBottomSheet();
              opensheet();
              //etarea.text = "My Stringt";
            });
          },
          child: new Theme(
            data: new ThemeData(
              primaryColor: AppColors.themecolor,
              primaryColorDark: AppColors.themecolor,
            ),
            child: new TextFormField(
              //focusNode: myFocusNode,
              onTap: () {},
              enabled: false,
              showCursor: false,
              readOnly: true,
              controller: etarea,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: AppColors.themecolor)),
                hintText: 'Enter area name or pincode',
                helperText: 'Keep it short, this is just a demo.',
                labelText: 'Area name Or Pincode',
              ),
              //validator: validatePincode,
              onSaved: (String val) {
                nArea = val;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        _submit();
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
          _sOtp,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // ---- Login
      print("reg_url_code-------------------------------");

      print(nName);
      print(nEmail);
      print(nPhoneNumber);
      print(nAddress);
      print(nPassord);
      print(IDCardClass.area_id);
      nArea_id = IDCardClass.area_id;

      print(nArea_id);

      if (nArea_id != null) {
        try {
          setState(() {
            _isLoggedIn = true;
          });

          var area_name = IDCardClass.area_name;
          var area_pin = IDCardClass.area_pin;
          var area_id = IDCardClass.area_id;

          var area_country = "IN";
          var area_state = IDCardClass.area_state;
          var area_city = IDCardClass.area_city;
          var last_name = "";

          /*https://www.svgs.co/api/signUp?first_name=abcqdef&last_name=&email=abced@abc.com&phone=1231231233&password=123456
          // &address1=test%20address&country=IN&postcode=605001&area_id=590&area=Pondicherry&state=Pondicherry&city=Pondicherry
*/
          await Provider.of<RegisterProvider>(
            context,
            listen: false,
          ).fetchAndSetReg(
              nName,
              last_name,
              nEmail,
              nPhoneNumber,
              nPassord,
              nAddress,
              area_country,
              area_pin,
              area_id,
              area_name,
              area_state,
              area_city);

          print("Login---------------------------------testing");

          final success = Provider.of<RegisterProvider>(
            context,
            listen: false,
          ).success;
          final error = Provider.of<RegisterProvider>(
            context,
            listen: false,
          ).error;

          if (success == 1) {
            final member_details = Provider.of<RegisterProvider>(
              context,
              listen: false,
            ).list_success_res;

            print("success=================================$success");

            var id = member_details[0]['id'];
            var name = member_details[0]['name'];
            var email = member_details[0]['email'];
            var phone = member_details[0]['phone'];

            print("id=================================$id");
            print("name=================================$name");
            print("email=================================$email");
            print("phone=================================$phone");

            // location
            var area_id = member_details[0]['area_id'];
            var area_name = member_details[0]['area_name'];
            Provider.of<UserDetailsProvider>(
              context,
              listen: false,
            ).storeUserData(
              id.toString(),
              name.toString(),
              email.toString(),
              phone.toString(),
              area_id.toString(),
              area_name.toString(),
            );

            print("area_id=================================$area_id");
            print("area_name=================================$area_name");

            _submit_verify_mob(id.toString(), "0", phone.toString());

            /* setState(() {
              _isLoggedIn = false;

            });*/

          } else {
            setState(() {
              _isLoggedIn = false;
              var str_v = "Already existing number";
              showInSnackBar(str_v);
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
        str_content = "Select your location.";
        alert_snack_login(str_content);
      }
    } else {
      //showInSnackBar('Please fix the errors in red before submitting.');
    }
  }

  Future<void> _submit_verify_mob(
      String id, String mob_v, String number) async {
    final form = formKey.currentState;

    // ---- Login
    print("reg_url_code-------------------------------");

    try {
      setState(() {
        _isLoggedIn = true;
      });

      await Provider.of<VerifyMobileProvider>(context)
          .fetchAndSetVerifyMobile(id, mob_v, number);

      print("Login---------------------------------testing");

      final success = Provider.of<VerifyMobileProvider>(context).success;
      final error = Provider.of<VerifyMobileProvider>(context).error;

      if (success == 1) {
        //final otp = Provider.of<SendOtpProvider>(context).otp;
        print("success=================================$success");
        final otp = Provider.of<VerifyMobileProvider>(context).otp;

        setState(() {
          _isLoggedIn = false;
        });

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: ((BuildContext context) {
              return DynamicDialog(
                  id: id, number: number, mob_v: mob_v, otp: otp.toString());
            }));
      } else {
        setState(() {
          _isLoggedIn = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoggedIn = false;
      });

      print("----------------------------------$error");
      throw error;
    }
  }

  void alert_snack_login(String str_content) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(str_content),
      duration: Duration(seconds: 3),
    ));
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.88,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Center(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment,
                  children: [
                    Text(
                      'Choose the location',
                      style: TextStyles.h1Heading,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: Colors.redAccent,
                            primaryColorDark: Colors.red,
                          ),
                          child: new TextField(
                            controller: myController_search_loc,
                            focusNode: _textFocus,
                            onChanged: (text) {
                              if (text.length >= 3) {
                                setState(() {
                                  _isProgress = true;
                                  // _submit_area_name(text.toString().trim());
                                });
                              } else {
                                setState(() {
                                  if (!data_area_pin.isEmpty) {
                                    data_area_pin.clear();
                                  }
                                  _isProgress = false;
                                });
                              }
                              print("First text field: $text");
                              print(
                                  "First text field: $myController_search_loc");
                            },
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              hintText: 'Enter the pincode',
                              helperText: 'Required 3 or more characters',
                              labelText: 'Enter the pincode',
                              prefixIcon: const Icon(
                                Icons.location_searching,
                                color: Colors.black,
                              ),
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              prefixText: ' ',
                              suffixText: '',
                              /*suffixStyle: const TextStyle(color: Colors.green)*/
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isProgress,
                      child: new Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: ListView.separated(
                          itemCount: data_area_pin.length,
                          separatorBuilder: (_, __) => Divider(height: 0.5),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(
                                  data_area_pin[index]['area_name'] != null
                                      ? data_area_pin[index]['area_name']
                                      : ""),
                              subtitle: Text(
                                  data_area_pin[index]['area_pincode'] != null
                                      ? data_area_pin[index]['area_pincode']
                                      : ""),
                              //trailing: Icon(Icons.arrow_forward_ios),
                              isThreeLine: false,
                              onTap: () {
                                print(
                                    "==========================================");
                                print(data_area_pin[index]['id']);
                                setState(() {
                                  // _submit_area_id(data_area_pin[index]['id'].toString());
                                });

                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }

  opensheet() async {
    print("444444444444444444444444444444444");
    var from_page = "SingUp";
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
          area_pincode = IDCardClass.area_name.toString() +
              "/" +
              IDCardClass.area_pin.toString();
          etarea.text = area_pincode;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _obscureText = true;
    Colors.white;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.whiteColor,
              )),
          title: Text(
            'Sign Up',
            style: TextStyles.actionTitle_w,
          ),
          backgroundColor: AppColors.themecolor,
        ),
        body: SafeArea(
            child: ModalProgressHUD(
                inAsyncCall: _isLoggedIn,
                child: new SingleChildScrollView(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new SafeArea(
                          top: false,
                          bottom: false,
                          child: Card(
                              elevation: 5.0,
                              margin: EdgeInsets.all(16.0),
                              child: Form(
                                  key: formKey,
                                  autovalidate: _autovalidate,
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          const SizedBox(height: 16.0),
                                          Text(
                                            'New User Signup!',
                                            style: TextStyles.txt_16_black_bold,
                                          ),
                                          const SizedBox(height: 24.0),
                                          _editText(),
                                          const SizedBox(height: 16.0),
                                          new Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                _submitButton()
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16.0),
                                          RichText(
                                            text: TextSpan(
                                              text: "Already have an account?",
                                              style: TextStyles
                                                  .txt_12_black_normal,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: " " + 'Login here',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            AppColors.blue_br,
                                                        fontSize: 12.0),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Login_Screen()));
                                                          }),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  )) //login,
                              ))
                    ],
                  ),
                ))));
  }

  @override
  void initState() {
    super.initState();
    //myFocusNode = FocusNode();
    //myFocusNode.requestFocus();
    WidgetsBinding.instance.addObserver(this);
    print("loose your game quick run");
  }

  @override
  void dispose() {
    // myController_search_loc.dispose();
    //myFocusNode.dispose();
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    state = state;
    print(state);
    print(":::::::");
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  // void _performLogin() {
  //   // This is just a demo, so no actual login here.
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => Home_screen()));
  // }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
