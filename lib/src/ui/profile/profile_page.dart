import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/providers/user_details_provider.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/user-profile';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var _userNameController = TextEditingController();
  var _userPhoneController = TextEditingController();
  var _userEmailController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _userPhoneController.dispose();
    _userEmailController.dispose();

    super.dispose();
  }

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
        _userNameController.text = member.name;
        _userPhoneController.text = member.phone;
        _userEmailController.text = member.email;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: AppColors.themecolor,
        title: Text(
          'Profile',
          style: TextStyles.actionTitle_w,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // height: 25.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            // margin: const EdgeInsets.only(left: 5.0,),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0)),
                            width: 230.0,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _userNameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  //user Phone
                  Container(
                    // height: 25.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(),
                            ),
                            width: 230.0,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _userPhoneController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),

                  ///user Email
                  Container(
                    // height: 25.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(),
                            ),
                            width: 230.0,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _userEmailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),

                  //submit button
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                        10.0,
                      )),
                      onPressed: () {},
                      color: AppColors.themecolor,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
