import 'package:flutter/material.dart';
import 'package:todo_app_task/utils/colorConstants.dart';
import 'package:todo_app_task/views/loginScreen/loginScreen.dart';
import 'package:todo_app_task/views/registerScreen/registration_screen.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.LightThemeBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'Welcome to Mimo',
                  style: TextStyle(
                      color: Colorconstants.LightThemeTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Please login to your account or create ',
                      style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'new account to continue',
                      style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Loginscreen(),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colorconstants.ThemeColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colorconstants.LightThemeTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colorconstants.ThemeColor,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "CREATE ACCOUNT",
                        style: TextStyle(
                            color: Colorconstants.LightThemeTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
