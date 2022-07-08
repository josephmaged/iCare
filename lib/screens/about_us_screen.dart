import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';

class aboutUsScreen extends StatefulWidget {
  static const String ID = "AboutUsScreen";
  @override
  _aboutUsScreenState createState() => _aboutUsScreenState();
}

class _aboutUsScreenState extends State<aboutUsScreen> {
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "About Us",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: primaryColor),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: secondaryColor),
                                      color: Colors.white.withOpacity(0.7)),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "ICARE is a website and mobile app which provide "
                                          "services to patients such as pill reminder and "
                                          "get a helpful health Consulting from doctors we "
                                          "provide also make a relationship between "
                                          "patients and their afraid relatives by follow-up their health informations from our system.",
                                      style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Our services",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: primaryColor),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "We provide total health care",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: secondaryColor,
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset('assets/images/doctor.png', height: 100),
                                            const Text(
                                              "Qualified Doctors",
                                              style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              "Get best consultations from "
                                                  "professional doctors.",
                                              style: TextStyle(fontSize: 14, color: darkTextColor, fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: secondaryColor,
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset('assets/images/blue_capsule.png', height: 100),
                                            const Text(
                                              "Daily Reminders",
                                              style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              "Pill reminder and chronic disease measurements.",
                                              style: TextStyle(fontSize: 14, color: darkTextColor, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: secondaryColor,
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset('assets/images/Phone.png', height: 100),
                                            const Text(
                                              "Health Progress Report",
                                              style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              "ICARE provide you a monthly report to "
                                                  "follow up your health.",
                                              style: TextStyle(fontSize: 14, color: darkTextColor, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Why Choose Us",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: primaryColor),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/Online_service.png",
                                      height: 60,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "A Personal and dedicated service.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/Man_communicates.png",
                                      height: 60,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Access to a 24 hour advice line.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/Woman_getting.png",
                                      height: 60,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Flexibility in your health cover.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                        "assets/images/Medicine.png",
                                        height: 60,
                                      ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Health and well-being services.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
