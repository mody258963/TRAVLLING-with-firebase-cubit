import 'package:flutter/material.dart';

class OPTverify extends StatefulWidget {
  const OPTverify({super.key});

  @override
  State<OPTverify> createState() => _OPTverifyState();
}

class _OPTverifyState extends State<OPTverify> {
  Widget _TextoftheVerfy() {
    return Column(
      children: [
        Text(
          "Verify your phone number",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("Enter your 6 digit code numbers sent to you at ##number##")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/fonts/image/photo-1517950908067-2d4181c93e31.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
