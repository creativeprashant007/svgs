import 'dart:collection';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:svgs_app/constants/AppColors.dart';
import 'package:svgs_app/constants/IDClass.dart';
import 'package:svgs_app/constants/textstyles.dart';
import 'package:svgs_app/model/Address_model.dart';
import 'package:svgs_app/providers/area_branch_provider.dart';
import 'package:svgs_app/providers/area_provider.dart';
import 'package:svgs_app/providers/login_provider.dart';
import 'package:svgs_app/providers/sendOtp_provider.dart';
import 'package:svgs_app/src/logind_signup.dart';
import 'package:flutter/material.dart';
import 'package:svgs_app/src/signup_screen.dart';
import 'package:svgs_app/widgets/sheet/showpage.dart';

class ShowModalPage extends StatefulWidget {
  ShowModalPage({this.from_page});
  final String from_page;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ShowModalPage> {
  final myController_search_loc = TextEditingController();
  bool _isProgress = false;
  final _textFocus = new FocusNode();
  List data_area_pin = [];
  String area_name = "";

  String _from_page = "";
  bool _skip_v = false;
  @override
  void initState() {
    super.initState();
    _from_page = widget.from_page;
    if (_from_page == 'Home') {
      _skip_v = true;
    } else {
      _skip_v = false;
    }
  }

  Future<void> _submit_area_name(String pattern) async {
    // final form = formKey.currentState;
    //   form.save();

    // ---- pattern
    print("pattern-------------------------------");
    print(pattern);

    try {
      setState(() {
        _isProgress = true;
      });
      await Provider.of<AreaProvider>(context, listen: false)
          .fetchAndSetArea(pattern);

      print("AreaProvider---------------------------------testing");

      final area_pincode =
          Provider.of<AreaProvider>(context, listen: false).area_items;

      if (!area_pincode.isEmpty) {
        //final otp = Provider.of<SendOtpProvider>(context).otp;
        print("area_pincode=================================#############");
        print(area_pincode[0].area_name);

        setState(() {
          if (!data_area_pin.isEmpty) {
            data_area_pin.clear();
          }

          for (int i = 0; i < area_pincode.length; i++) {
            Map<String, String> map = new Map<String, String>();
            map['area_name'] = area_pincode[i].area_name;
            map['area_pincode'] = area_pincode[i].area_pincode;
            map['id'] = area_pincode[i].id;

            map['area_country'] = area_pincode[i].area_country;
            map['area_state'] = area_pincode[i].area_state;
            map['area_city'] = area_pincode[i].area_city;

            data_area_pin.add(map);
          }

          print("_isProgress=================================$data_area_pin");
          _isProgress = false;
        });
      } else {
        setState(() {
          _isProgress = false;
        });
      }
    } catch (error) {
      print("----------------------------------$error");
      throw error;
    }
  }

  Future<void> _submit_area_id(String id) async {
    print("khan_testing-------------------------------");
    // final form = formKey.currentState;
    //   form.save();

    // ---- pattern
    print("pattern-------------------------------");
    print(id);

    try {
      setState(() {
        _isProgress = true;
      });
      await Provider.of<AreaBranchProvider>(context, listen: false)
          .fetchAndSetBranch(id);

      print("AreaBranchProvider---------------------------------testing");

      final branchid =
          Provider.of<AreaBranchProvider>(context, listen: false).branchid;
      final pin = Provider.of<AreaBranchProvider>(context, listen: false).pin;
      final area = Provider.of<AreaBranchProvider>(context, listen: false).area;

      final success =
          Provider.of<AreaBranchProvider>(context, listen: false).success;

      print("branchid-------------------------------------------------------");
      print(branchid);
      print(pin);
      print(area);
      print("-------------------------------------------------------");
      //widget.area_pincode

      area_name = area;

      setState(() {
        _isProgress = false;

        if (success == 1) {
          IDCardClass.area_name = area;
          IDCardClass.area_pin = pin;
          IDCardClass.branchid = branchid;

          print(
              "early_called------------------------------------------------------");
          //Navigator.of(context).pop();

          if (!branchid.isEmpty) {
            _sendDataBack(context);
          } else {
            _exitApp(context);
          } // if =====================================================================>

        }
      });

      print("9999999999999999999999999999999999");
    } catch (error) {
      print("error----------------------------------$error");
      throw error;
    }
  }

  // get the text in the TextField and send it back to the FirstScreen
  void _sendDataBack(BuildContext context) {
    print(
        "========================WAHT I SAY====================================");
    //String textToSendBack = textFieldController.text;
    Navigator.of(context).pop();
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Signup_Screen(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      //text = result;
    });
  }
  /* openothersheet(String pin,String area) async {
          return Signup_Screen();
  }*/

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('OOPS!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Sorry, We do not have delivery to your area.'),
                  Text('We will be there soon!'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  _submit_area_id('590');
                  Navigator.of(context).pop(false);
                  //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        print("testing_messurement");
        _submit_area_id('590');
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
        child: InkWell(
          child: Text(
            "Skip & Explore",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Container(
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
                                    _submit_area_name(text.toString().trim());
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
                                  //setState(() {

                                  IDCardClass.area_id =
                                      data_area_pin[index]['id'];
                                  IDCardClass.area_name =
                                      data_area_pin[index]['area_name'];
                                  IDCardClass.area_pin =
                                      data_area_pin[index]['area_pincode'];

                                  //IDCardClass.branchid = data_area_pin[index]['area_country'];

                                  IDCardClass.area_country =
                                      data_area_pin[index]['area_country'];
                                  IDCardClass.area_state =
                                      data_area_pin[index]['area_state'];
                                  IDCardClass.area_city =
                                      data_area_pin[index]['area_city'];

                                  if (_from_page == 'Home') {
                                    _submit_area_id(
                                        data_area_pin[index]['id'].toString());
                                  } else {
                                    _sendDataBack(context);
                                  }
                                  //
                                  //});
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _skip_v,
                        child: _submitButton(),
                      )
                    ],
                  ))),
        ));
  }
}
