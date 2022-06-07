// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_function_declarations_over_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/screens/tips/gain.dart';
import 'package:icare/screens/tips/lose.dart';
import 'package:icare/screens/tips/maintain.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:icare/widget/reusbleCustomAppbar.dart';
import 'package:intl/intl.dart';

class tipsScreen extends StatefulWidget {
  static const String ID = "TipsScreen";

  @override
  _tipsScreenState createState() => _tipsScreenState();
}

class _tipsScreenState extends State<tipsScreen> {
  final controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _loseIsPressed = true;
  bool _maintainIsPressed = false;
  bool _gainIsPressed = false;


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    ReusbleCustomAppbar(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 80),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _loseIsPressed ? secondaryColor : Colors.white,
                                      ),
                                      onPressed: () {
                                        controller.jumpToPage(0);
                                            setState(() {
                                              _loseIsPressed = true;
                                              _maintainIsPressed = false;
                                              _gainIsPressed = false;
                                            });
                                      },
                                      child: Text('Lose', style: TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _maintainIsPressed ? secondaryColor : Colors.white,
                                      ),
                                      onPressed: () {
                                         controller.jumpToPage(1);
                                         setState(() {
                                           _loseIsPressed = false;
                                           _maintainIsPressed = true;
                                           _gainIsPressed = false;
                                         });
                                      },
                                      child: Text(
                                        'Maintain',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _gainIsPressed ? secondaryColor : Colors.white,
                                      ),
                                      onPressed: () {
                                        controller.jumpToPage(2);
                                        setState(() {
                                            _loseIsPressed = false;
                                            _maintainIsPressed = false;
                                            _gainIsPressed = true;
                                        });
                                      },
                                      child: Text('Gain', style: TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              SizedBox(
                                height: screenHeight - 240,
                                width: double.infinity,
                                child: PageView(
                                  controller: controller,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    loseScreen(),
                                    maintainScreen(),
                                    gainScreen(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  MaterialStateProperty<Color>getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states){
      if (states.contains(MaterialState.pressed)){
        return colorPressed;
      }
      else {
        return color;
      }
    };

    return MaterialStateProperty.resolveWith(getColor);
  }
}
