import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';

class loseScreen extends StatefulWidget {

  @override
  _loseScreenState createState() => _loseScreenState();
}

final List<String> drinkTipsImg = <String>[
  "assets/images/tips_image/1.png",
  "assets/images/tips_image/2.png",
  "assets/images/tips_image/3.png",
  "assets/images/tips_image/4.png",
  "assets/images/tips_image/5.png",
  "assets/images/tips_image/6.png",
];
final List<String> foodTipsImg = <String>[
  "assets/images/tips_image/7.png",
  "assets/images/tips_image/8.png",
  "assets/images/tips_image/9.png",
  "assets/images/tips_image/10.png",
  "assets/images/tips_image/11.png",
  "assets/images/tips_image/12.png",
];
final List<String> drinkTipsName = <String> [
  'Match',
  'Green Tea',
  'Lemon Water',
  'Ginger Tea',
  'Ajwain Water',
  'Cumin Tea'
];
final List<String> foodTipsName = <String>[
  'Grapefruit',
  'Yogurt',
  'Nuts',
  'Beans',
  'Soup',
  'Vegetables',
];

class _loseScreenState extends State<loseScreen> {

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
              child: const Center(
                child: Text(
                  'Drinks',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: drinkTipsName.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 150,
                        child: Image.asset(drinkTipsImg[index]),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  drinkTipsName[index],
                                  style: const TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: primaryColor,
              ),
              child: const Center(
                child: Text(
                  'Foods',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: foodTipsName.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 150,
                        child: Image.asset(foodTipsImg[index]),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  foodTipsName[index],
                                  style: const TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold),
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
