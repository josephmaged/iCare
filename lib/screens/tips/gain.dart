// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';

class gainScreen extends StatefulWidget {
  const gainScreen({Key? key}) : super(key: key);

  @override
  _gainScreenState createState() => _gainScreenState();
}

final List<String> drinkTipsImg = <String>[
  "assets/images/tips_image/13.png",
  "assets/images/tips_image/14.png",
  "assets/images/tips_image/15.png",
  "assets/images/tips_image/16.png",
  "assets/images/tips_image/17.png",
  "assets/images/tips_image/18.png",
];
final List<String> foodTipsImg = <String>[
  "assets/images/tips_image/19.png",
  "assets/images/tips_image/20.png",
  "assets/images/tips_image/21.png",
  "assets/images/tips_image/22.png",
  "assets/images/tips_image/23.png",
  "assets/images/tips_image/24.png",
];
final List<String> drinkTipsName = <String>[
  'Banana nut butter shake',
  'Chocolate shake',
  'Strawberry banana smoothie',
  'Blueberry smoothie',
  'Nutella',
  'Snickers',
];
final List<String> foodTipsName = <String> [
  'Rice',
  'Pasta',
  'Red meat',
  'Nut Butter',
  'Potatoes',
  'Cheese'
];

class _gainScreenState extends State<gainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: primaryColor,
              ),
              child: Center(
                child: Text(
                  'Drinks',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemCount: drinkTipsName.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        child: Image.asset(drinkTipsImg[index]),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  drinkTipsName[index],
                                  style: TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: primaryColor,
              ),
              child: Center(
                child: Text(
                  'Foods',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemCount: foodTipsName.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        child: Image.asset(foodTipsImg[index]),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  foodTipsName[index],
                                  style: TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
