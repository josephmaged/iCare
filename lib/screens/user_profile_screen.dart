import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';

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
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                        Row(
                          children: [
                            Hero(
                              tag: "appbarImage",
                              child: Image.asset('assets/images/patient.png'),
                            ),
                            Text(
                              'Hello, \n${toBeginningOfSentenceCase(userList[3])!}',
                              style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 380),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            hintText: 'Name',
                            hintStyle: const TextStyle(color: lightTextColor),
                            suffixIcon: IconButton(
                              onPressed: nameController.clear,
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                          controller: nameController,
                        ),
                        const SizedBox(height: 20),
                        const Text(
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
                                title: const Text(
                                  'Male',
                                  style: TextStyle(color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
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
                                title: const Text(
                                  'Female',
                                  style: TextStyle(color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
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
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Height',
                                    hintStyle: TextStyle(color: lightTextColor)),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                controller: heightController,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Weight',
                                    hintStyle: TextStyle(color: lightTextColor)),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                controller: weightController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'BirthDate',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                            ),
                            Container(
                              height: 40,
                              width: 180,
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), border: Border.all(color: primaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _birthDate(context);
                                    },
                                    child: Text(
                                      "$birthDate".split(' ')[0],
                                      style:
                                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: lightTextColor),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: primaryColor,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Contact',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: lightTextColor)),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                          controller: emailController,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Phone',
                              hintStyle: TextStyle(color: lightTextColor)),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                          controller: phoneNumController,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
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
