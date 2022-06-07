import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icare/doctor/chat/chat_with_patient.dart';
import 'package:icare/doctor/chat/doctor_chat_screen.dart';
import 'package:icare/doctor/doctor_home.dart';
import 'package:icare/doctor/doctor_profile.dart';
import 'package:icare/modul/Posts.dart';
import 'package:icare/screens/about_us_screen.dart';
import 'package:icare/screens/add_appointments_screen.dart';
import 'package:icare/screens/appointments_screen.dart';
import 'package:icare/screens/calories_screen.dart';
import 'package:icare/screens/chat/chat_with_doctor.dart';
import 'package:icare/screens/chat/chat_screen.dart';
import 'package:icare/screens/event_details_screen.dart';
import 'package:icare/screens/exercise_screen.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/screens/login_screen.dart';
import 'package:icare/screens/medicine_schedule_screen.dart';
import 'package:icare/screens/post_comments_screen.dart';
import 'package:icare/screens/posts_screen.dart';
import 'package:icare/screens/signup_screen.dart';
import 'package:icare/screens/tips_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:icare/screens/welcome.dart';
import 'package:icare/screens/add_medicine_screen.dart';
import 'package:icare/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCARE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        SplashScreen.ID: (context) => SplashScreen(),
        welcomeScreen.ID: (context) => welcomeScreen(),
        aboutUsScreen.ID: (context) => aboutUsScreen(),
        LoginScreen.ID: (context) => LoginScreen(),
        SignupScreen.ID: (context) => SignupScreen(),
        UserProfileScreen.ID: (context) => UserProfileScreen(),
        HomeScreen.ID: (context) => HomeScreen(),
        addMedicineScreen.ID: (context) => addMedicineScreen(),
        scheduleScreen.ID: (context) => scheduleScreen(),
        tipsScreen.ID: (context) => tipsScreen(),
        eventDetailsScreen.ID: (context) => eventDetailsScreen(),
        chatWithDoctorScreen.ID: (context) => chatWithDoctorScreen(),
        chatScreen.ID: (context) => chatScreen(),
        appointmentScreen.ID: (context) => appointmentScreen(),
        exerciseScreen.ID: (context) => exerciseScreen(),
        caloriesScreen.ID: (context) => caloriesScreen(),
        doctorHomeScreen.ID: (context) => doctorHomeScreen(),
        chatWithPatientScreen.ID: (context) => chatWithPatientScreen(),
        doctorChatScreen.ID: (context) => doctorChatScreen(),
        addAppointmentsScreen.ID: (context) => addAppointmentsScreen(),
        PostsScreen.ID: (context) => PostsScreen(),
        DoctorProfile.ID: (context) => DoctorProfile(),
        postCommentsScreen.ID: (context) => postCommentsScreen()
      },
      home: SplashScreen(),
    );
  }
}
