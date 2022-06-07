import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/doctor/chat/chat_with_patient.dart';
import 'package:icare/doctor/doctor_home.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/screens/login_screen.dart';
import 'package:icare/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String ID = 'SplashScreen';

  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() {
      _navigateToHome();
    });
    super.initState();
  }

  String? finalEmail;
  String? ruleId;

  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var startEmail = sharedPreferences.getString('email');
    final SharedPreferences rulePreference = await SharedPreferences.getInstance();
    var startRuleId = rulePreference.getString('ruleId');
    setState(() {
      finalEmail = startEmail;
      ruleId = startRuleId;
    });
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 2));
    if (finalEmail == null) {
      Navigator.of(context).pushReplacementNamed(welcomeScreen.ID);
    } else {
      if (ruleId == 'false') {
        Navigator.of(context).pushReplacementNamed(HomeScreen.ID);
      } else {
        Navigator.of(context).pushReplacementNamed(doctorHomeScreen.ID);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/mainLogo.png",
          color: primaryColor,
          width: 300.0,
        ),
      ),
    );
  }
}
