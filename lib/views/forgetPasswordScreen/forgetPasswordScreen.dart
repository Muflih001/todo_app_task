import 'package:flutter/material.dart';
import 'package:todo_app_task/utils/colorConstants.dart';

import 'package:todo_app_task/views/registerScreen/registration_screen.dart';

class Forgetpasswordscreen extends StatefulWidget {
  const Forgetpasswordscreen({super.key});

  @override
  State<Forgetpasswordscreen> createState() => _ForgetpasswordscreenState();
}

class _ForgetpasswordscreenState extends State<Forgetpasswordscreen> {
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.LightThemeBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colorconstants.LightThemeTextColor,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colorconstants.LightThemeTextColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colorconstants.LightThemeTextColor,
                style: TextStyle(color: Colorconstants.LightThemeTextColor),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 2),
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
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter the email address you used to create your account',
                    style: TextStyle(color: Colorconstants.LightThemeTextColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'and we will email you a link to reset password',
                    style: TextStyle(color: Colorconstants.LightThemeTextColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  

                  if (_usernameController.text.isNotEmpty) {
                   
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please enter a valid email'),
                      ),
                    );
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colorconstants.ThemeColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            "CONTINUE",
                            style: TextStyle(
                              color: Colorconstants.DarkThemeTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        // Todo : write code  to navigate to registration screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
