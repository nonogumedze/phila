import 'package:flutter/material.dart';
import 'package:phila/Login/login_screen.dart';
import 'package:phila/Screens/Doctor/doctor_screen.dart';
import 'package:phila/Screens/Nurse/nurse_screen.dart';
import 'package:phila/Screens/home.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String nurseHome = '/nurse/home';
  static const String doctorHome = '/doctor/home';
  static const String uploadSequence = '/nurse/upload-sequence';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case nurseHome:
        return MaterialPageRoute(builder: (_) => const NurseHomeScreen());
      case doctorHome:
        return MaterialPageRoute(builder: (_) => const DoctorHomeScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
