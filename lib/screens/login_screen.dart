// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/doctor/chat/chat_with_patient.dart';
import 'package:icare/doctor/doctor_home.dart';
import 'package:icare/modul/Users.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/screens/signup_screen.dart';
import 'package:icare/screens/welcome.dart';
import 'package:icare/services/DataBaseManager.dart';
import 'package:icare/services/auth_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String ID = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firebase = FirebaseFirestore.instance;

  bool showSpinner = false;

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType, Icon prefixIcon,
      {bool obscureText = false}) {
    return TextField(
      controller: userInput,
      autocorrect: false,
      enableSuggestions: false,
      autofocus: false,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        hintText: hintTitle,
        hintStyle:
            TextStyle(fontSize: 18, color: lightTextColor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      ),
      keyboardType: keyboardType,
    );
  }

  List userList = [];
  String? ruleID;

  fetchDatabaseList() async {
    dynamic resultdata = await DataBaseManager().getUserData(email: emailController.text);
    if (resultdata == null) {
      print("enable to get ");
    } else {
      setState(() {
        userList = resultdata;
        ruleID = userList[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed(welcomeScreen.ID),
                          icon: Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                      ],
                    ),
                    Image.asset('assets/images/login.png')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor),
                                ),
                              ),
                              SizedBox(height: 20),
                              userInput(emailController, 'Email', TextInputType.emailAddress, Icon(Icons.email)),
                              SizedBox(height: 20),
                              userInput(
                                passwordController,
                                'Password',
                                TextInputType.visiblePassword,
                                Icon(Icons.vpn_key_rounded),
                                obscureText: true,
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 55,
                                padding: const EdgeInsets.only(top: 5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    primary: primaryColor,
                                    onPrimary: secondaryColor,
                                  ),
                                  onPressed: () async {
                                    showSpinner = true;
                                    try {
                                      final currentUser = await _auth.signInWithEmailAndPassword(
                                          email: emailController.text, password: passwordController.text);
                                      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                      sharedPreferences.setString('email', emailController.text);
                                      await fetchDatabaseList();
                                      if (ruleID == "false") {
                                        final SharedPreferences rulePreference = await SharedPreferences.getInstance();
                                        rulePreference.setString('ruleId', ruleID.toString());
                                        Navigator.of(context).pushNamed(HomeScreen.ID);
                                      } else {
                                        final SharedPreferences rulePreference = await SharedPreferences.getInstance();
                                        rulePreference.setString('ruleId', ruleID!);
                                        Navigator.of(context).pushNamed(doctorHomeScreen.ID);
                                      }
                                      print(ruleID);
                                      showSpinner = false;
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  'Forgot password ?',
                                  style: TextStyle(color: darkTextColor),
                                ),
                              ),
                              SizedBox(height: 20),
                              Divider(thickness: 0, color: Colors.white),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account yet ? ',
                                    style: TextStyle(color: lightTextColor, fontStyle: FontStyle.italic),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pushNamed(SignupScreen.ID),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
