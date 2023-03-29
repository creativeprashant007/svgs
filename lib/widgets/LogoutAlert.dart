import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';

class LogoutDialog extends StatefulWidget {
  LogoutDialog({this.id});

  final String id;

  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<LogoutDialog> {
  String _id;
  String _number;
  String _mob_v;
  String _otp;
  String nOtp = "";

  final formKey = GlobalKey<FormState>();
  bool _isLoggedIn = false;

  @override
  void initState() {
    _id = widget.id;
    super.initState();
  }

  @override
  void dispose() {
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
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Logout",
                              style: TextStyles.h1Heading,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Do you want to logout ?",
                              style: TextStyles.txt_14_black_normal,
                            ),
                          ),
                          SizedBox(
                            height: 16,
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
                                onTap: () {},
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
                                              AppColors.separatorGrey,
                                              AppColors.separatorGrey,
                                              AppColors.separatorGrey
                                            ])),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {},
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
                                        "Yes",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    )),
                              ),
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
