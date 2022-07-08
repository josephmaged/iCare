import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/widget/reusbleCustomAppbar.dart';

class exerciseScreen extends StatefulWidget {
  static const String ID = "ExerciseScreen";

  @override
  _exerciseScreenState createState() => _exerciseScreenState();
}

class _exerciseScreenState extends State<exerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: primaryColor,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: const [
                    ReusbleCustomAppbar(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 49,
                                    width: 174,
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: secondaryColor,
                                    ),
                                    child: Row(
                                      children: const [
                                        Hero(
                                          tag: 'exercise',
                                          child: Icon(
                                            Icons.directions_run,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Exercise',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset('assets/images/exercise/Exercise.png', scale: 1.5)
                                ],
                              ),
                              Container(
                                height: 70,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: secondaryColor,width: 3)
                                ),
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/exercise/haveNiceDay.png'),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Have a nice day',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Image.asset("assets/images/exercise/1.png"),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Image.asset("assets/images/exercise/2.png"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Yoga',
                                        style: TextStyle(
                                            color: tipsTestColor, fontWeight: FontWeight.bold,fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Stretching',
                                        style: TextStyle(
                                            color: tipsTestColor, fontWeight: FontWeight.bold,fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Image.asset("assets/images/exercise/3.png"),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Image.asset("assets/images/exercise/4.png"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Squats',
                                        style: TextStyle(
                                            color: tipsTestColor, fontWeight: FontWeight.bold,fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Plank',
                                        style: TextStyle(
                                            color: tipsTestColor, fontWeight: FontWeight.bold,fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Image.asset("assets/images/exercise/5.png"),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Image.asset("assets/images/exercise/6.png"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Push Up',
                                        style: TextStyle(
                                            color: tipsTestColor, fontWeight: FontWeight.bold,fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Expanded(
                                            child: Text(
                                              'Jumping Rope',
                                              style: TextStyle(
                                                  color: tipsTestColor, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
