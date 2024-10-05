import 'package:flutter/material.dart';
import 'package:todo_app_task/utils/colorConstants.dart';
import 'package:todo_app_task/views/welcomScreen/welcomeScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Welcomescreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mark_chat_read,
            color: Colorconstants.ThemeColor,
            size: 100,
          ),
          Text(
            'mimo',
            style: TextStyle(
              color: Colorconstants.LightThemeTextColor,
              fontSize: 42,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          )
        ],
      )),
    );
  }
}
