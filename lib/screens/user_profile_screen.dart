// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';

enum Gender { Male, Female }

class UserProfileScreen extends StatefulWidget {
  static const String ID = "UserProfileScreen";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

DateTime birthDate = DateTime(2010);

final nameController = TextEditingController();
final heightController = TextEditingController();
final weightController = TextEditingController();
final emailController = TextEditingController();
final phoneNumController = TextEditingController();

class _UserProfileScreenState extends State<UserProfileScreen> {
  static const String ID = "UserProfile";

  Gender? _gender = Gender.Male;

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/doctor.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Personal Information',
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor),
                                  ),
                                  Text(
                                    'About You',
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: primaryColor),
                                  ),
                                  SizedBox(height: 25),
                                  TextField(
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Name',
                                      hintStyle: TextStyle(color: lightTextColor),
                                      suffixIcon: IconButton(
                                        onPressed: nameController.clear,
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                    controller: nameController,
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
                                            style: TextStyle(
                                                color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
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
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              hintText: 'Height',
                                              hintStyle: TextStyle(color: lightTextColor)),
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                          controller: heightController,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Flexible(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              hintText: 'Weight',
                                              hintStyle: TextStyle(color: lightTextColor)),
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                          controller: weightController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'BirthDate',
                                        style:
                                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 180,
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: primaryColor)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                _birthDate(context);
                                              },
                                              child: Text(
                                                "$birthDate".split(' ')[0],
                                                style: TextStyle(
                                                    fontSize: 20, fontWeight: FontWeight.bold, color: lightTextColor),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down_circle,
                                              color: primaryColor,
                                              size: 30,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    'Contact',
                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: primaryColor),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(color: lightTextColor)),
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                    controller: emailController,
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Phone',
                                      hintStyle: TextStyle(
                                        color: lightTextColor
                                      )
                                    ),
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: darkTextColor),
                                    controller: phoneNumController,
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

  _birthDate(BuildContext context) async {
    final DateTime? dayOfBirth = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2010),
    );
    if (dayOfBirth != null && dayOfBirth != birthDate) {
      setState(() {
        birthDate = dayOfBirth;
      });
    }
  }
}
