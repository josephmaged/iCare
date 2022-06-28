// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, unnecessary_new, prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/screens/report_screen.dart';
import 'package:icare/screens/user_details_screen.dart';
import 'package:icare/services/DataBaseManager.dart';
import 'package:icare/screens/chat/chat_with_doctor.dart';
import 'package:icare/screens/medicine_schedule_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modul/Users.dart';
import '../widget/homeBody.dart';
import 'display_doctor_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String ID = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final _auth = FirebaseAuth.instance;
var loggedInUser;
var loggedInUserEmail;
List userList = [];

DateFormat format = new DateFormat("MMMM dd, yy");
var dateString = format.format(DateTime.now());
DateFormat dayFormat = new DateFormat("EEEE");
var dayString = dayFormat.format(DateTime.now());

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false; //<-- SEE HERE
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchDatabaseList();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        loggedInUserEmail = user.email;
      }
    } catch (e) {
      print(e);
    }
  }

  fetchDatabaseList() async {
    dynamic resultdata = await DataBaseManager().getUserData(email: loggedInUserEmail);
    if (resultdata == null) {
      print("enable to get ");
    } else {
      setState(() {
        userList = resultdata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.lightBlueAccent.withOpacity(0.5), BlendMode.dstATop),
                    image: AssetImage("assets/images/drawerBackground.jpg"),
                    fit: BoxFit.fitWidth,
                  )),
                  child: Image.asset(
                    "assets/images/mainLogo.png",
                    alignment: Alignment.topLeft,
                    color: primaryColor,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('LogOut'),
                  onTap: () async {
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.remove('email');
                    final SharedPreferences rulePreference = await SharedPreferences.getInstance();
                    rulePreference.remove('ruleId');

                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed(LoginScreen.ID);
                  },
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                            icon: Icon(Icons.menu),
                            color: Colors.grey,
                            iconSize: 35,
                          ),
                          Column(
                            children: [
                              Text(
                                dayString + "  " + dateString,
                                style: TextStyle(color: primaryColor, fontSize: 18),
                              ),
                              Text(
                                "Hi, " + (userList.isNotEmpty ? toBeginningOfSentenceCase(userList[3])! : ''),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(UserDetailsScreen.ID),
                                child: Image.asset(
                                  'assets/images/patient.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: FirestoreSearchBar(
                          tag: 'HomeSearsh',
                          clearSearchButtonColor: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: FirestoreSearchResults.builder(
                    tag: 'HomeSearsh',
                    firestoreCollectionName: 'Users',
                    searchBy: 'First Name',
                    initialBody: HomeBody(),
                    dataListFromSnapshot: Users().dataListFromSnapshot,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<Users>? dataList = snapshot.data;
                        if (dataList!.isEmpty) {
                          return const Center(
                            child: Text('No Result Found'),
                          );
                        }
                        return ListView.builder(
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              final Users data = dataList[index];
                              return GestureDetector(
                                onTap: ()=>  {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DisplayDoctorScreen(data),
                                    ),
                                  ),
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(border: Border.all(color: primaryColor)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          'Dr.${toBeginningOfSentenceCase(data.firstName)}',
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                                        child: Text(
                                          '${data.docMajor}',
                                          style: TextStyle(
                                            fontSize: 18
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("No Result Returned"),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            backgroundColor: primaryColor,
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.of(context).pushNamed(chatWithDoctorScreen.ID);
                  break;
                case 1:
                  Navigator.of(context).pushNamed(scheduleScreen.ID);
                  break;
                case 2:
                  Navigator.of(context).pushNamed(reportScreen.ID);
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services),
                label: 'Medications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                label: 'Reports',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
