import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_task/utils/colorConstants.dart';
import 'package:todo_app_task/views/forgetPasswordScreen/forgetPasswordScreen.dart';
import 'package:todo_app_task/views/homeScreen/homeScreen.dart';
import 'package:todo_app_task/views/registerScreen/registration_screen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'mimo',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                        fontStyle: FontStyle.italic,
                        color: Colorconstants.LightThemeTextColor),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colorconstants.LightThemeTextColor,
                style: TextStyle(color: Colorconstants.LightThemeTextColor),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
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
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                obscuringCharacter: '.',
                cursorColor: Colorconstants.LightThemeTextColor,
                style: TextStyle(color: Colorconstants.LightThemeTextColor),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  suffixIcon: IconButton(
                    // Add a suffix icon
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value != null && value.length >= 8) {
                    return null;
                  } else {
                    return 'Password must containe atleast 8 character';
                  }
                },
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Forgetpasswordscreen(),
                            ));
                      },
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  final storedUsername = prefs.getString('username');
                  final storedPassword = prefs.getString('password');
                  if (_usernameController.text == storedUsername &&
                      _passwordController.text == storedPassword) {
                    // Credentials are correct, navigate to the next screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Invalid username or password'),
                      ),
                    );
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "CONTINUE",
                            style: TextStyle(
                                color: Colorconstants.DarkThemeTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                  ),
                  decoration: BoxDecoration(
                      color: Colorconstants.ThemeColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
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
