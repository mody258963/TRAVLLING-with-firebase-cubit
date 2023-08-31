import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traelling_app/bessnes_logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:traelling_app/costanse/colors.dart';
import 'package:traelling_app/costanse/pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController _controller = TextEditingController();
String phoneNumber = _controller.text;
bool push = false;

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  void _Circelindecator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        builder: (context) {
          return alertDialog;
        });
  }

  Future<void> _regester(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      _formKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).sumbitPhoneNumbr(phoneNumber);
    }
  }

  Widget _buildPhoneNumberSumbit() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (BuildContext context, PhoneAuthState state) {
        if (state is Loading) {
          _Circelindecator(context);
        }
        if (state is PhonwNumberSumbited) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(Optpage, arguments: phoneNumber);
        }
        if (state is ErrorOccurred) {
          String erromasg = (state).errorMsg;
          print("===================================== $erromasg");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(erromasg),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 6),
          ));
        }
      },
      child: Container(),
    );
  }

  Widget _SocialMediaButtons() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: hight * 0.065,
          width: width * 0.90,
          child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: MyColors.whitefade,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9))),
              icon: Padding(
                padding: EdgeInsets.only(
                  right: width * 0.18,
                ),
                child: Icon(
                  Icons.email_outlined,
                ),
              ),
              label: Padding(
                padding: EdgeInsets.only(right: width * 0.22),
                child: Text("Continue with Email",
                    style: TextStyle(color: MyColors.white)),
              )),
        ),
        SizedBox(
          height: hight * 0.02,
        ),
        Container(
          height: hight * 0.065,
          width: width * 0.90,
          child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: MyColors.whitefade,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9))),
              icon: Padding(
                padding: EdgeInsets.only(
                  right: width * 0.18,
                ),
                child: Icon(
                  Icons.facebook_outlined,
                ),
              ),
              label: Padding(
                padding: EdgeInsets.only(right: width * 0.11),
                child: Text("Continue with Facebook"),
              )),
        ),
        SizedBox(
          height: hight * 0.02,
        ),
        Container(
          height: hight * 0.065,
          width: width * 0.90,
          child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: MyColors.whitefade,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9))),
              icon: Padding(
                padding: EdgeInsets.only(
                  right: width * 0.18,
                ),
                child: Icon(
                  Icons.g_mobiledata,
                ),
              ),
              label: Padding(
                padding: EdgeInsets.only(right: width * 0.17),
                child: Text("Continue with Gmail"),
              )),
        ),
        SizedBox(
          height: hight * 0.02,
        ),
        Container(
          height: hight * 0.065,
          width: width * 0.90,
          child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: MyColors.whitefade,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9))),
              icon: Padding(
                padding: EdgeInsets.only(
                  right: width * 0.18,
                ),
                child: Icon(
                  Icons.apple_outlined,
                ),
              ),
              label: Padding(
                padding: EdgeInsets.only(right: width * 0.17),
                child: Text("Continue with Apple"),
              )),
        ),
      ],
    );
  }

  Widget _lineoftheOR() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        SizedBox(
          width: width * 0.06,
        ),
        Container(
          width: width * 0.41,
          child: Divider(
            thickness: 1,
            color: MyColors.gray,
          ),
        ),
        Text(" or "),
        Container(
          width: width * 0.41,
          child: Divider(
            thickness: 1,
            color: MyColors.gray,
            height: hight * 0.10,
          ),
        ),
      ],
    );
  }

  Widget _buttonofconfirmation() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Container(
      height: hight * 0.07,
      width: width * 0.90,
      child: ElevatedButton(
        onPressed: () {
          print(
              '===================================================$phoneNumber');
          _Circelindecator(context);

          _regester(context);
        },
        child: Text('Continue', style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
            primary: MyColors.realblack,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
      ),
    );
  }

  Widget _TextunderthetextFieild() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Container(
        width: width * 0.90,
        child: Text("We'll call as soon as possible by a message or a call."));
  }

  String _EgyptionFlage() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  Widget _TextFieldEg() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: hight * 0.073,
          width: width * 0.90,
          decoration: BoxDecoration(
              color: MyColors.white,
              border: Border.all(color: MyColors.black),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                  bottomLeft: Radius.circular(1),
                  bottomRight: Radius.circular(1))),
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.02, top: width * 0.031),
            child: Text(
              _EgyptionFlage() + "   |   Egypt (+20) ",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: width * 0.055),
            ),
          ),
        ),
        Container(
            height: hight * 0.075,
            width: width * 0.90,
            child: TextFormField(
              validator: (value) {
                if (value!.length < 11 || value.length > 11) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: MyColors.white,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: MyColors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: MyColors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))

                    //<-- SEE HERE
                    ),
                hintText: "Phone Number",
                hintStyle: TextStyle(fontSize: width * 0.049),
              ),
              cursorHeight: 25,
              keyboardType: TextInputType.phone,
              controller: _controller,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    void dispose() {
      super.dispose();
      _controller.dispose();
    }

    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/fonts/image/photo-1517950908067-2d4181c93e31.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: hight * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.047,
                        bottom: hight * 0.04,
                      ),
                      child: Text("Login or Create an account",
                          style: TextStyle(
                              fontSize: width * 0.08, color: MyColors.white)),
                    ),
                    _TextFieldEg(),
                    SizedBox(
                      height: hight * 0.01,
                    ),
                    _TextunderthetextFieild(),
                    SizedBox(
                      height: hight * 0.03,
                    ),
                    _buttonofconfirmation(),
                    _lineoftheOR(),
                    _SocialMediaButtons(),
                    _buildPhoneNumberSumbit()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
