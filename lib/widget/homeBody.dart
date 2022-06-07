import 'package:flutter/material.dart';
import 'package:icare/screens/appointments_screen.dart';
import 'package:icare/screens/calories_screen.dart';
import 'package:icare/screens/exercise_screen.dart';
import 'package:icare/screens/posts_screen.dart';
import 'package:icare/screens/tips_screen.dart';
import 'package:icare/widget/reusbleHomeBox.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              reusbleHomeBox(
                titleText: "Calories",
                bodyIcon: Icons.local_fire_department,
                iconTag: 'calories',
                boxPressed: () => Navigator.of(context).pushNamed(caloriesScreen.ID),
              ),
            ],
          ),
          Row(
            children: [
              reusbleHomeBox(
                  titleText: "Exercise",
                  bodyIcon: Icons.directions_run,
                  boxPressed: () => Navigator.of(context).pushNamed(exerciseScreen.ID),
                  iconTag: 'exercise'),
              reusbleHomeBox(
                  titleText: "Tips",
                  bodyIcon: Icons.receipt,
                  boxPressed: () => Navigator.of(context).pushNamed(tipsScreen.ID),
                  iconTag: 'tips'),
            ],
          ),
          Row(
            children: [
              reusbleHomeBox(
                  titleText: "Ask A Doctor",
                  bodyIcon: Icons.format_quote,
                  boxPressed: () => Navigator.of(context).pushNamed(PostsScreen.ID) ,
                  iconTag: 'ask'),
              reusbleHomeBox(
                  titleText: "Appointments",
                  bodyIcon: Icons.schedule,
                  boxPressed: () => Navigator.of(context).pushNamed(appointmentScreen.ID),
                  iconTag: 'appointments'),
            ],
          )
        ],
      ),
    );
  }
}