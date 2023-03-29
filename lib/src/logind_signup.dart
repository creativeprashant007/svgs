import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/colors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/cart_provider.dart';
import 'package:svgs_app/providers/login_provider.dart';
import 'package:svgs_app/providers/sendOtp_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/src/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:svgs_app/src/ui/home/homepage.dart';

class Login_Screen extends StatefulWidget {
  static const routeName = '/login';
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const Login_Screen(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.yellow, fontSize: 24.0),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => login();
}

class login extends State<Login_Screen> {
  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  bool timer_count = false;
  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  bool _formWasEdited = false;
  bool _showOTP = false;
  bool _isInAsyncCall = false;
  bool _isLoggedIn = false;
  var _sOtp = "Send OTP";

  bool resend_v = false;

  String validateMobile(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter mobile number.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value.length != 10) return 'Enter valid mobile number.';
    return null;
  }

  String validateOTP(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter OTP.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value != str_Otp) return 'Enter valid OTP.';
    return null;
  }

  Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer_count = false;
            _start = 0;
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  TextEditingController etMobileNumber = new TextEditingController();
  TextEditingController etOTP = new TextEditingController();

  String nMobilenumber = "";
  String nOtp = "";
  String str_Otp = "";

  Widget _editText() {
    return Column(
      children: <Widget>[
        new Theme(
          data: new ThemeData(
            primaryColor: AppColors.themecolor,
            primaryColorDark: AppColors.themecolor,
          ),
          child: new TextFormField(
            onChanged: (text) {
              print("Number of count ---------------------------");
              print(text);
              if (text.length == 10) {
                setState(() {
                  _submit();
                });
              } else {
                setState(() {
                  _showOTP = false;
                  str_Otp = "Send OTP";
                });
              }
            },
            controller: etMobileNumber,
            maxLength: 10,
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: false),
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: AppColors.themecolor)),
              hintText: 'Enter mobile number',
              /* helperText: 'Keep it short, this is just a demo.',*/
              labelText: 'Mobile Number',
              prefixIcon: const Icon(
                Icons.phone_iphone,
                color: AppColors.themecolor,
              ),
            ),
            validator: validateMobile,
            onSaved: (String val) {
              nMobilenumber = val;
            },
          ),
        ),
        SizedBox(height: 16),
        Visibility(
            visible: _showOTP,
            child: new Theme(
              data: new ThemeData(
                primaryColor: AppColors.themecolor,
                primaryColorDark: AppColors.themecolor,
              ),
              child: new TextFormField(
                controller: etOTP,
                obscureText: false,
                autofocus: false,
                maxLength: 4,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: AppColors.themecolor)),
                  hintText: 'Enter OTP',
                  /* helperText: 'Keep it short, this is just a demo.',*/
                  labelText: 'OTP',
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.themecolor,
                  ),
                ),
                validator: validateOTP,
                onSaved: (String val) {
                  nOtp = val;
                },
              ),
            ))
      ],
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        _submit();
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
                colors: (_showOTP == false)
                    ? [Color(0xFF28a745), Color(0xFF28a745), Color(0xFF28a745)]
                    : [
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
            'Login',
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
                                            'Login With OTP',
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
                                          Visibility(
                                            visible: resend_v,
                                            child: RichText(
                                              text: TextSpan(
                                                text:
                                                    "Didn't you receive any code?",
                                                style: TextStyles
                                                    .txt_12_black_normal,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: " " +
                                                          'Resend OTP' +
                                                          "(" +
                                                          _start.toString() +
                                                          ")",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .themecolor,
                                                          fontSize: 14.0),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              if (timer_count ==
                                                                  false) {
                                                                _submitResend();
                                                              }

                                                              //Navigator.push(context, MaterialPageRoute(builder: (context)=> Signup_Screen()));
                                                            }),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16.0),
                                          RichText(
                                            text: TextSpan(
                                              text: "Don't have an account?",
                                              style: TextStyles
                                                  .txt_12_black_normal,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: " " + 'Sign Up',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppColors.blue_br,
                                                        fontSize: 14.0),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Signup_Screen()));
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

  Future<void> _submit() async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      nMobilenumber = etMobileNumber.text.toString().trim();

      if (_showOTP == true) {
        // ---- Login
        print("login_url_code-------------------------------");
        nOtp = etOTP.text.toString().trim();

        print(nMobilenumber);
        print(nOtp);

        try {
          setState(() {
            _isLoggedIn = true;
          });
          final uniqueId =
              Provider.of<ApiProviders>(context, listen: false).uid;
          //await Provider.of<SendOtpProvider>(context,listen: false).fetchAndSetSendOTP(nMobilenumber.toString());

          print('uniqueId===========================' + uniqueId);

          await Provider.of<LoginProvider>(context, listen: false)
              .fetchAndSetLogin(
                  nMobilenumber.toString(), nOtp.toString(), uniqueId);

          print("Login---------------------------------testing");

          final success =
              Provider.of<LoginProvider>(context, listen: false).success;
          final error =
              Provider.of<LoginProvider>(context, listen: false).error;
          final member_details =
              Provider.of<LoginProvider>(context, listen: false)
                  .list_success_res;

          if (success == 1) {
            //final otp = Provider.of<SendOtpProvider>(context).otp;
            print("success=================================$success");

            var mem_Id = member_details[0]['id'];
            var name = member_details[0]['name'];
            var email = member_details[0]['email'];
            var phone = member_details[0]['phone'];

            // location
            var area_id = member_details[0]['area_id'];
            var area_name = member_details[0]['area_name'];

            await Provider.of<UserDetailsProvider>(context, listen: false)
                .storeUserData(
              mem_Id.toString(),
              name.toString(),
              email.toString(),
              phone.toString(),
              area_id.toString(),
              area_name.toString(),
            );
            await Provider.of<UserDetailsProvider>(context, listen: false)
                .fetchUserDetails();
            final uniqueId =
                await Provider.of<ApiProviders>(context, listen: false).uid;
            print("uniqueId_home_page===============================$uniqueId");

            final user_details =
                await Provider.of<UserDetailsProvider>(context, listen: false)
                    .userDetails;
            String memberId = user_details[0].memberId.toString().trim();
            await Provider.of<CartProvider>(context, listen: false);
            final branchId =
                await Provider.of<AreaBranchProvider>(context, listen: false)
                    .branch_id_v;
            await Provider.of<CartProvider>(context, listen: false)
                .fetchAndSetCartItem(branchId, uniqueId, memberId);

            setState(() {
              _isLoggedIn = false;
            });

            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => HomePage()),
            //     ModalRoute.withName("/src/homepage"));
            Navigator.of(context).pop();
          } else {
            setState(() {
              _isLoggedIn = false;
            });
          }
        } catch (error) {
          print("----------------------------------$error");
          throw error;
        }
      } else {
        // send otp -------------------------------
        try {
          setState(() {
            _isLoggedIn = true;
          });

          await Provider.of<SendOtpProvider>(context, listen: false)
              .fetchAndSetSendOTP(nMobilenumber.toString());

          print("----------------------------------testing");

          final success =
              Provider.of<SendOtpProvider>(context, listen: false).success;
          final error =
              Provider.of<SendOtpProvider>(context, listen: false).error;

          if (success == 1) {
            final otp =
                Provider.of<SendOtpProvider>(context, listen: false).otp;
            print("otp=================================$otp");
            str_Otp = otp.toString();

            setState(() {
              _showOTP = true;
              _sOtp = "Login";
              _isLoggedIn = false;
              resend_v = true;
              startTimer();
            });
          } else {
            setState(() {
              print("error=================================$error");
              _showOTP = false;
              _sOtp = "Send OTP";
              _isLoggedIn = false;
              resend_v = false;
              var str_v = "Enter valid number";
              showInSnackBar(str_v);
            });
          }
        } catch (error) {
          print("----------------------------------$error");
          throw error;
        }
      }
    } else {
      //showInSnackBar('Please fix the errors in red before submitting.');
    }
  }

  Future<void> _submitResend() async {
    // final form = formKey.currentState;

    nMobilenumber = etMobileNumber.text.toString().trim();

    if (!nMobilenumber.isEmpty) {
      // send otp -------------------------------
      try {
        setState(() {
          _isLoggedIn = true;
        });

        await Provider.of<SendOtpProvider>(context, listen: false)
            .fetchAndSetSendOTP(nMobilenumber.toString());

        print("----------------------------------testing");

        final success =
            Provider.of<SendOtpProvider>(context, listen: false).success;
        final error =
            Provider.of<SendOtpProvider>(context, listen: false).error;

        if (success == 1) {
          final otp = Provider.of<SendOtpProvider>(context, listen: false).otp;
          print("otp=================================$otp");
          str_Otp = otp.toString();

          setState(() {
            _showOTP = true;
            _sOtp = "Login";
            _isLoggedIn = false;
            resend_v = true;
            _start = 60;
            timer_count = true;
            startTimer();
          });
        } else {
          setState(() {
            _showOTP = false;
            _sOtp = "Send OTP";
            _isLoggedIn = false;
            resend_v = false;
          });
        }
      } catch (error) {
        print("----------------------------------$error");
        throw error;
      }
    } else {
      var str_v = "Enter mobile number";
      showInSnackBar(str_v);
    }
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
