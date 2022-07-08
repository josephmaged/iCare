import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
            const TextStyle(fontSize: 18, color: lightTextColor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      ),
      keyboardType: keyboardType,
    );
  }

  List userList = [];
  String? ruleID;

  fetchDatabaseList() async {
    dynamic resultdata = await DataBaseManager().getUserData(email: emailController.text);
    if (resultdata == null) {
      if (kDebugMode) {
        print("enable to get ");
      }
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
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed(welcomeScreen.ID),
                          icon: const Icon(Icons.arrow_back),
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
                    decoration: const BoxDecoration(
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
                              const SizedBox(height: 10),
                              const Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor),
                                ),
                              ),
                              const SizedBox(height: 20),
                              userInput(emailController, 'Email', TextInputType.emailAddress, const Icon(Icons.email)),
                              const SizedBox(height: 20),
                              userInput(
                                passwordController,
                                'Password',
                                TextInputType.visiblePassword,
                                const Icon(Icons.vpn_key_rounded),
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
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
                                      if (kDebugMode) {
                                        print(ruleID);
                                      }
                                      showSpinner = false;
                                    } catch (e) {
                                      String errorE = e.toString();
                                      if (errorE == '[firebase_auth/unknown] Given String is empty or null') {
                                        var snackBar = const SnackBar(content: Text('Please fill empty.'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      } else if (errorE ==
                                          '[firebase_auth/invalid-email] The email address is badly formatted.') {
                                        var snackBar = const SnackBar(content: Text('Please enter a correct email.'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      } else if (errorE ==
                                          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
                                        var snackBar = const SnackBar(content: Text('Email not found.'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }else if (errorE ==
                                          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                                        var snackBar = const SnackBar(content: Text('Password is invalid.'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Center(
                                child: Text(
                                  'Forgot password ?',
                                  style: TextStyle(color: darkTextColor),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Divider(thickness: 0, color: Colors.white),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account yet ? ',
                                    style: TextStyle(color: lightTextColor, fontStyle: FontStyle.italic),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pushNamed(SignupScreen.ID),
                                    child: const Text(
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
