import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/doctor/chat/chat_with_patient.dart';
import 'package:icare/doctor/doctor_home.dart';
import 'package:icare/modul/Users.dart';
import 'package:icare/services/DataBaseManager.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/screens/login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  static const String ID = "SignUpScreen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showSpinner = false;

  bool isDoctor = false;

  OnDoctorSwitchChanged(bool notDoctor) {
    setState(() {
      isDoctor = notDoctor;
    });
  }

  final auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType, Icon prefixIcon,
      {bool obscureText = false}) {
    return TextFormField(
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
        hintStyle: const TextStyle(
            fontSize: 18, color: lightTextColor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      ),
      keyboardType: keyboardType,
    );
  }

  final Users _users = Users();

  Future<void> createUser(
      {required String firstName,
      required String lastName,
      required String ruleID,
      required String userEmail,
      String? doctorMajor,
      String? Gender,
      String? Birthday,
      String? phone,
      String? clinicAddress,
      String? aboutDoc}) async {
    _users.firstName = firstName;
    _users.lastName = lastName;
    _users.ruleID = ruleID;
    _users.userEmail = userEmail;
    _users.docMajor = '';
    _users.gender = '';
    _users.birthday = '';
    _users.phone = '';
    _users.clinicAddress = '';
    _users.aboutDoc = '';

    await FirebaseFirestore.instance.collection('Users').doc(emailController.text).set(_users.toJson());
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
                  image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                        Expanded(child: Image.asset('assets/images/signup.png')),
                        const SizedBox(width: 35),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 250),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 10),
                            const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor),
                              ),
                            ),
                            const SizedBox(height: 20),
                            userInput(firstNameController, 'First Name', TextInputType.name, const Icon(Icons.person)),
                            const SizedBox(height: 20),
                            userInput(lastNameController, 'Last Name', TextInputType.name,
                                const Icon(Icons.perm_contact_cal)),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Are You Doctor ?',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch(
                                        value: isDoctor,
                                        onChanged: (notDoctor) {
                                          OnDoctorSwitchChanged(notDoctor);
                                        }),
                                  ),
                                ),
                              ],
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
                                  if (kDebugMode) {
                                    print(emailController.text);
                                  }
                                  if (kDebugMode) {
                                    print(passwordController.text);
                                  }
                                  try {
                                    if (isDoctor == false) {
                                      await auth.createUserWithEmailAndPassword(
                                          email: emailController.text, password: passwordController.text);
                                      createUser(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          ruleID: isDoctor.toString(),
                                          userEmail: emailController.text);

                                      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                      sharedPreferences.setString('email', emailController.text);
                                      final SharedPreferences rulePreference = await SharedPreferences.getInstance();
                                      rulePreference.setString('ruleId', isDoctor.toString());
                                      Navigator.of(context).pushNamed(HomeScreen.ID);
                                    } else {
                                      await auth.createUserWithEmailAndPassword(
                                          email: emailController.text, password: passwordController.text);
                                      createUser(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          ruleID: 'true',
                                          userEmail: emailController.text);
                                      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                      sharedPreferences.setString('email', emailController.text);
                                      final SharedPreferences rulePreference = await SharedPreferences.getInstance();
                                      rulePreference.setString('ruleId', isDoctor.toString());
                                      Navigator.of(context).pushNamed(doctorHomeScreen.ID);
                                    }
                                    showSpinner = false;
                                  } catch (e) {
                                    String errorE = e.toString();
                                    if (errorE ==
                                        '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
                                      var snackBar = const SnackBar(content: Text('Email already in use.'));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else if (errorE == '[firebase_auth/unknown] Given String is empty or null') {
                                      var snackBar = const SnackBar(content: Text('Please fill empty.'));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else if (errorE ==
                                        '[firebase_auth/invalid-email] The email address is badly formatted.') {
                                      var snackBar = const SnackBar(content: Text('Please enter a correct email.'));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else if (errorE ==
                                        '[firebase_auth/weak-password] Password should be at least 6 characters') {
                                      var snackBar =
                                          const SnackBar(content: Text('Password should be at least 6 characters.'));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                    if (kDebugMode) {
                                      print(e);
                                    }
                                  }
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(thickness: 0, color: Colors.white),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Do you have an account ? ',
                                  style: TextStyle(color: lightTextColor, fontStyle: FontStyle.italic),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pushNamed(LoginScreen.ID),
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
