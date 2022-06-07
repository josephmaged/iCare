// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:icare/screens/about_us_screen.dart';
import 'package:icare/screens/login_screen.dart';
import 'package:icare/screens/signup_screen.dart';

import 'package:icare/const/const.dart';

class welcomeScreen extends StatefulWidget {
  static const String ID = "WelcomeScreen";

  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  colorFilter: ColorFilter.mode(secondaryColor.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage("assets/images/drawerBackground.jpg"),
                  fit: BoxFit.fitWidth,
                )),
                child: Image.asset(
                  "assets/images/mainLogo.png",
                  alignment: Alignment.topLeft,
                  scale: 8,
                ),
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Login'),
                onTap: () => Navigator.of(context).pushNamed(LoginScreen.ID),
              ),
              ListTile(
                leading: Icon(Icons.app_registration),
                title: Text('Register'),
                onTap: () => Navigator.of(context).pushNamed(SignupScreen.ID),
              ),
              ListTile(
                leading: Icon(Icons.support_agent),
                title: Text('Contact Us'),
                onTap: () => Navigator.of(context).pushNamed(aboutUsScreen.ID),
              ),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: IconButton(
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      icon: Icon(Icons.menu),
                      color: Colors.white,
                      iconSize: 35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "WELCOME TO",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Image.asset(
                              "assets/images/mainLogo.png",
                              color: Colors.white,
                              height: 50,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/images/backgroundDoctor.png',
                            width: 120,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48,
                          width: 274,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(width: 1, color: Colors.black)),
                              primary: primaryColor.withOpacity(0.05),
                              onPrimary: secondaryColor.withOpacity(0),
                              shadowColor: Colors.black.withOpacity(0.1)
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(LoginScreen.ID),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 48,
                          width: 274,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(width: 1, color: Colors.black)),
                              primary: primaryColor.withOpacity(0.05),
                              onPrimary: secondaryColor.withOpacity(0),
                                shadowColor: Colors.black.withOpacity(0.1)
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(SignupScreen.ID),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
