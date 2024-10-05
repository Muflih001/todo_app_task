import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_task/utils/colorConstants.dart';
import 'package:todo_app_task/views/dummydb.dart';
import 'package:todo_app_task/views/loginScreen/loginScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameController = TextEditingController();
  final _regemailController = TextEditingController();
  final _regpasswordController = TextEditingController();
  final _regconformpasswordController = TextEditingController();
  var profileBox = Hive.box<dynamic>('profileBox');
  @override
  Widget build(BuildContext context) {
    

    final formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colorconstants.LightThemeBackgroundColor,
        
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SafeArea(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colorconstants.LightThemeTextColor,
                          size: 40,
                        )),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create an Account",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colorconstants.LightThemeTextColor),
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border:
                              const OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        style: TextStyle(
                            color: Colorconstants.LightThemeTextColor),
                        controller: _regemailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border:
                              const OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter a valid email';
                          } else if (value.contains('@')) {
                            return null;
                          } else {
                            return 'invalid email adrees';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                            color: Colorconstants.LightThemeTextColor),
                        controller: _regpasswordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border:
                              const OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        validator: (value) {
                          if (value != null && value.length >= 8) {
                            return null;
                          } else {
                            return 'Password must containe atleast 8 character';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                            color: Colorconstants.LightThemeTextColor),
                        controller: _regconformpasswordController,
                        decoration: InputDecoration(
                          hintText: 'Conform Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border:
                              const OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        validator: (value) {
                          if (value != null && value.length >= 8) {
                            return null;
                          } else {
                            return 'Password must containe atleast 8 character';
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            usernamereg = _regemailController.text;
                            passwordreg = _regpasswordController.text;
                            if (_regpasswordController.text ==
                                _regconformpasswordController.text) {
                              // Store the username and password using shared_preferences
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('username', usernamereg);
                              await prefs.setString('password', passwordreg);
                              profileBox.put(
                                  'username', _usernameController.text);
                              // Navigate to the next screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Loginscreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Invalid username or password'),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colorconstants.ThemeColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "CONTINUE",
                              style: TextStyle(
                                  color: Colorconstants.DarkThemeTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // Todo : write code  to navigate to Login screen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Loginscreen(),
                              ));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colorconstants.ThemeColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
