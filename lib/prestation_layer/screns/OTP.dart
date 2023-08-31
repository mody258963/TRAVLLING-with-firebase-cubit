import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:traelling_app/bessnes_logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:traelling_app/costanse/colors.dart';
import 'package:traelling_app/costanse/pages.dart';
import 'package:traelling_app/prestation_layer/screns/login.dart';

class OPTverify extends StatefulWidget {
  const OPTverify({super.key, this.phoneNumber});
  final phoneNumber;

  @override
  State<OPTverify> createState() => _OPTverifyState();
}

String? otpCode;
Widget _buildPhoneNumberSumbit() {
  return BlocListener<PhoneAuthCubit, PhoneAuthState>(
    listenWhen: (previous, current) {
      return previous != current;
    },
    listener: (BuildContext context, PhoneAuthState state) {
      if (state is Loading) {
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              child: Text('fuck you'),
            );
          },
        );
      }
      if (state is PhoneOTPVerified) {
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed(posters);
      }
    },
    child: Container(),
  );
}

class _OPTverifyState extends State<OPTverify> {
  Future<void> _login(BuildContext context) {
    return BlocProvider.of<PhoneAuthCubit>(context).submitOPT(otpCode!);
  }

  Widget _verfybutton() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Container(
      height: hight * 0.07,
      width: width * 0.90,
      child: ElevatedButton(
        onPressed: () {
          _login(context);
        },
        child: Text('Verify', style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
            primary: MyColors.realblack,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
      ),
    );
  }

  Widget _Pincodetextfield() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.90,
      child: PinCodeTextField(
        length: 6,
        enablePinAutofill: true,
        keyboardType: TextInputType.phone,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          selectedColor: MyColors.white,
          inactiveColor: Colors.black,
          selectedFillColor: Colors.black,
          inactiveFillColor: MyColors.white,
          disabledColor: MyColors.white,
          activeColor: MyColors.white,
          activeFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        onCompleted: (code) {
          otpCode = code;
        },
        onChanged: (value) {
          print(value);
          setState(() {});
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
        appContext: context,
      ),
    );
  }

  Widget _TextoftheVerfy() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            Container(
              width: width * 0.90,
              child: Text(
                "Verify your phone number",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.08,
                    color: MyColors.white),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
          child: Text(
            "Enter your 6 digit code numbers sent to you at $phoneNumber",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.04,
                color: MyColors.white),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              SizedBox(
                height: hight * 0.10,
              ),
              _TextoftheVerfy(),
              SizedBox(
                height: hight * 0.05,
              ),
              _Pincodetextfield(),
              SizedBox(
                height: hight * 0.09,
              ),
              _verfybutton()
            ],
          ),
        ),
      ),
    );
  }
}
