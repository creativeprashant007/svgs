import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/api_provider.dart';
import 'package:svgs_app/providers/sendOtp_provider.dart';
import 'package:svgs_app/providers/user_details_provider.dart';
import 'package:svgs_app/providers/verifyotp_provider.dart';
import 'package:svgs_app/src/ui/home/homepage.dart';

class DynamicDialog extends StatefulWidget {
  DynamicDialog({this.id, this.number, this.mob_v, this.otp});

  final String id;
  final String number;
  final String mob_v;
  final String otp;

/*  final String str_message;
  final String str_message_hint;
  final String str_btn;*/

  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  String _id;
  String _number;
  String _mob_v;
  String _otp;
  String nOtp = "";

  Timer _timer;
  int _start = 60;
  bool timer_count = false;

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

  bool _isLoggedIn = false;
  bool _autovalidate = false;
  bool resend_v = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController etOTP = new TextEditingController();
  String validateOTP(String value) {
    //_formWasEdited = true;
    if (value.isEmpty) return 'Enter OTP.';
    //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value != _otp) return 'Enter valid OTP.';
    return null;
  }

  Future<void> _submit() async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      nOtp = etOTP.text.toString().trim();

      print("login_url_code-------------------------------");
      nOtp = etOTP.text.toString().trim();

      print(_number);
      print(nOtp);

      try {
        setState(() {
          _isLoggedIn = true;
        });

        //await Provider.of<SendOtpProvider>(context).fetchAndSetSendOTP(nMobilenumber.toString());
        final uniqueId = Provider.of<ApiProviders>(context).uid;

        await Provider.of<VerifyOTPProvider>(context).fetchAndSetVerifyOTP(
            _number.toString(), nOtp.toString(), uniqueId);

        print("Login---------------------------------testing");

        final success = Provider.of<VerifyOTPProvider>(context).success;
        final error = Provider.of<VerifyOTPProvider>(context).error;

        final member_details =
            Provider.of<VerifyOTPProvider>(context).list_success_res;

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

          Provider.of<UserDetailsProvider>(context).storeUserData(
            mem_Id.toString(),
            name.toString(),
            email.toString(),
            phone.toString(),
            area_id.toString(),
            area_name.toString(),
          );

          print("area_id=================================$area_id");
          print("area_name=================================$area_name");

          setState(() {
            _isLoggedIn = false;
          });

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              ModalRoute.withName("/src/homepage"));
        } else {
          setState(() {
            _isLoggedIn = false;
          });
        }
      } catch (error) {
        print("----------------------------------$error");
        throw error;
      }
    } else {}
  }

  Future<void> _submitResend() async {
    // final form = formKey.currentState;

    // send otp -------------------------------
    try {
      setState(() {
        _isLoggedIn = true;
      });

      await Provider.of<SendOtpProvider>(context)
          .fetchAndSetSendOTP(_number.toString());

      print("----------------------------------testing");

      final success = Provider.of<SendOtpProvider>(context).success;
      final error = Provider.of<SendOtpProvider>(context).error;

      if (success == 1) {
        final otp = Provider.of<SendOtpProvider>(context).otp;
        print("otp=================================$otp");
        _otp = otp.toString();

        setState(() {
          _isLoggedIn = false;
          resend_v = true;
          _start = 60;
          timer_count = true;
          startTimer();
        });
      } else {
        setState(() {
          _isLoggedIn = false;
          resend_v = false;
          timer_count = false;
        });
      }
    } catch (error) {
      print("----------------------------------$error");
      throw error;
    }
  }

  @override
  void initState() {
    _id = widget.id;
    _number = widget.number;
    _mob_v = widget.mob_v;
    _otp = widget.otp;

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).orientation == Orientation.portrait;
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: ModalProgressHUD(
            inAsyncCall: _isLoggedIn,
            child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0)), //this right here
                child: SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: new Container(
                              color: Colors.white,
                              margin: new EdgeInsets.all(16.0),
                              width: double.infinity,
                              height: 96.0,
                              child: new Image.network(
                                  'https://www.svgs.co/data/logo/scart-mid.png',
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Verify OTP Code",
                              style: TextStyles.h1Heading,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Mobile Number: " + _number,
                              style: TextStyles.txt_14_black_normal,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Form(
                            key: formKey,
                            autovalidate: _autovalidate,
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
                                      borderSide: new BorderSide(
                                          color: AppColors.themecolor)),
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
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: InkWell(
                                  onTap: () {
                                    _submit();
                                  },
                                  child: Container(
                                    width: 120.0,
                                    height: 40.0,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
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
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Verify",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                  ))),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Didn't you receive any code?",
                              style: TextStyles.txt_14_black_normal,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                              child: Row(
                            //mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (timer_count = false) {
                                    _submitResend();
                                  }
                                },
                                child: Container(
                                    width: 120.0,
                                    height: 40.0,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
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
                                              AppColors.persianColor,
                                              AppColors.persianColor,
                                              AppColors.persianColor
                                            ])),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Resend OTP",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Visibility(
                                visible: resend_v,
                                child: Text(
                                  "(" + _start.toString() + ")".toString(),
                                  style: TextStyles.txt_14_black_normal,
                                ),
                              )
                            ],
                          )),
                          SizedBox(
                            height: 16,
                          ),

                          /*  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Back",
                      style: TextStyles.txt_14_black_normal,
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),*/
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
