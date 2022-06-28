// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare/const/const.dart';
import 'package:icare/widget/reusbleCustomAppbar.dart';

enum Gender { Male, Female }
enum ActivityLevel { Little, exOneToThree, exFourToFive, inThreeToFour, inSixToSeven }

class caloriesScreen extends StatefulWidget {
  static const String ID = "CaloriesScreen";

  @override
  _caloriesScreenState createState() => _caloriesScreenState();
}

Gender? _gender = Gender.Male;
ActivityLevel? _activityLevel = ActivityLevel.Little;

final ageController = TextEditingController();
final heightController = TextEditingController();
final weightController = TextEditingController();

num? finalBmiResult;
num? finalBmrResult;
num? finalCaloriesResult;
num? calories;
num? finalDayCalories;

Future calculateBmi({required double height, required double weight}) async {
  num heightByMeter;
  num heightByMeterSquare;
  num BMI;

  // cm to meters
  heightByMeter = height / 100;
  // square of height
  heightByMeterSquare = pow(heightByMeter, 2);
  BMI = weight / heightByMeterSquare;

  return BMI;
}

Future calculateBmr({required String gender, required int age, required double height, required double weight}) async {
  num BMR;

  if (gender == 'Male') {
    BMR = (10 * weight) + (6.25 * height) - (5 * age) + 5;
  } else {
    BMR = (10 * weight) + (6.25 * height) - (5 * age) + 161;
  }
  return BMR;
}

Future calculateCalories({required String activity}) async {

  //{ Little, exOneToThree, exFourToFive, inThreeToFour, inSixToSeven }
  if (activity == "Little") {
    calories = (finalBmrResult! * 1.1);
  } else if (activity == "exOneToThree") {
    calories = (finalBmrResult! * 1.25);
  } else if (activity == "exFourToFive") {
    calories = (finalBmrResult! * 1.375);
  } else if (activity == "inThreeToFour") {
    calories = (finalBmrResult! * 1.55);
  }
  return calories;
}

Future dayNeedCalories() async {
  num? dayCalories;

  if (finalBmiResult! <= 18.5){
    dayCalories = await calories! + 500;
  }else if (finalBmiResult! >= 25 ){
    dayCalories = await calories! - 500;
  }else {
    dayCalories = await finalCaloriesResult;
  }
  return dayCalories;
}


class _caloriesScreenState extends State<caloriesScreen> {

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your Body Index: ${finalBmiResult!.toStringAsFixed(2)}'),
                Text('Your Metabolic Rate: ${finalCaloriesResult!.toStringAsFixed(0)}'),
                Text('Your Daily needed Calories to have a nice shape: ${finalDayCalories!.toStringAsFixed(0)}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 49,
                                    width: 174,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: secondaryColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Hero(
                                          tag: 'calories',
                                          child: Icon(
                                            Icons.local_fire_department,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Calories',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset('assets/images/calories.png', scale: 1.5)
                                ],
                              ),
                              Text(
                                'Basic Information',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Gender',
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: darkTextColor),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 160,
                                    child: RadioListTile(
                                      title: Text(
                                        'Male',
                                        style:
                                            TextStyle(color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      value: Gender.Male,
                                      onChanged: (Gender? value) {
                                        setState(() {
                                          _gender = value;
                                        });
                                      },
                                      groupValue: _gender,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 160,
                                    child: RadioListTile(
                                      title: Text(
                                        'Female',
                                        style:
                                            TextStyle(color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      value: Gender.Female,
                                      onChanged: (Gender? value) {
                                        setState(() {
                                          _gender = value;
                                        });
                                      },
                                      groupValue: _gender,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Age',
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: darkTextColor),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Age',
                                  hintStyle: TextStyle(color: lightTextColor),
                                ),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                controller: ageController,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Flexible(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Height (cm)',
                                          hintStyle: TextStyle(color: lightTextColor)),
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                      controller: heightController,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Flexible(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Weight (kg)',
                                          hintStyle: TextStyle(color: lightTextColor)),
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                      controller: weightController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Activity Level',
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: darkTextColor),
                              ),
                              RadioListTile(
                                title: Text(
                                  'Little or no exercise.',
                                  style: TextStyle(color: darkTextColor, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                value: ActivityLevel.Little,
                                onChanged: (ActivityLevel? value) {
                                  setState(() {
                                    _activityLevel = value;
                                  });
                                },
                                groupValue: _activityLevel,
                              ),
                              RadioListTile(
                                title: Text(
                                  'Exercise 1-3 times/week.',
                                  style: TextStyle(color: darkTextColor, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                value: ActivityLevel.exOneToThree,
                                onChanged: (ActivityLevel? value) {
                                  setState(() {
                                    _activityLevel = value;
                                  });
                                },
                                groupValue: _activityLevel,
                              ),
                              RadioListTile(
                                title: Text(
                                  'Exercise 4-5 times/week.',
                                  style: TextStyle(color: darkTextColor, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                value: ActivityLevel.exFourToFive,
                                onChanged: (ActivityLevel? value) {
                                  setState(() {
                                    _activityLevel = value;
                                  });
                                },
                                groupValue: _activityLevel,
                              ),
                              RadioListTile(
                                title: Text(
                                  'Intense exercise 3-4 times/week.',
                                  style: TextStyle(color: darkTextColor, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                value: ActivityLevel.inThreeToFour,
                                onChanged: (ActivityLevel? value) {
                                  setState(() {
                                    _activityLevel = value;
                                  });
                                },
                                groupValue: _activityLevel,
                              ),
                              RadioListTile(
                                title: Text(
                                  'Intense exercise 6-7 times/week.',
                                  style: TextStyle(color: darkTextColor, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                value: ActivityLevel.inSixToSeven,
                                onChanged: (ActivityLevel? value) {
                                  setState(() {
                                    _activityLevel = value;
                                  });
                                },
                                groupValue: _activityLevel,
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                height: 48,
                                width: 274,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    primary: primaryColor,
                                  ),
                                  onPressed: () async {
                                    try {
                                      finalBmiResult = await calculateBmi(
                                          height: double.parse(heightController.text),
                                          weight: double.parse(weightController.text));
                                      finalBmrResult = await calculateBmr(
                                          gender: _gender!.name,
                                          age: int.parse(ageController.text),
                                          height: double.parse(heightController.text),
                                          weight: double.parse(weightController.text));
                                      finalCaloriesResult = await calculateCalories(activity: _activityLevel!.name);
                                      finalDayCalories = await dayNeedCalories();
                                      _showMyDialog();
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text(
                                    'Calculate',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
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
}
