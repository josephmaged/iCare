import 'package:flutter/material.dart';

import '../const/const.dart';


Widget reusbleHomeBox(
    {required String titleText,
      required IconData bodyIcon,
      required String iconTag,
      Function? boxPressed}) {
  return Expanded(
    child: InkWell(
      onTap: () => boxPressed!(),
      child: Container(
        margin: EdgeInsets.all(15),
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: primaryColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleText,
              style: homeMainTextStyle,
            ),
            SizedBox(height: 10),
            Hero(
              tag: iconTag,
              child: Icon(
                bodyIcon,
                color: homeIconsColor,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
