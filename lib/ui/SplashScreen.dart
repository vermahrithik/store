import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:store/ui/homePage.dart';

import '../models/UserData.dart';
import '../utils/ColorConstants.dart';
import '../utils/dialogs/DialogUtil.dart';
import 'loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginPage();
  }

  _navigateToLoginPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 1500), () {});
    print(jsonDecode(prefs.getString('usermodal').toString()));
    if (jsonDecode(prefs.getString('usermodal').toString()).toString() !=
        "null") {
      final Map<String, dynamic> jsonData =
      jsonDecode(prefs.getString('usermodal').toString());
      UserData usermodal = UserData.fromJson(jsonData);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProductListPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Center(
        child: Container(
          // height: 140,
          // width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
            boxShadow:
            [
              BoxShadow(color: ColorConstants.primaryColor),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48, // Image radius
            backgroundImage: AssetImage('assets/logo.jpg'),
          ),
          // decoration: BoxDecoration(
          //   color: ColorConstants.primaryColorTwo,
          //   borderRadius: BorderRadius.circular(80),
          //   boxShadow: const [
          //     BoxShadow(
          //       color: Color(0xff1c1c1c),
          //       offset: Offset(0.0, 0.0),
          //       blurRadius: 8.0,
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
