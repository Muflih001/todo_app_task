import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_task/controllers/settingsScreenController.dart';
import 'package:todo_app_task/utils/colorConstants.dart';
import 'package:todo_app_task/utils/imageConstants.dart';
import 'package:todo_app_task/views/loginScreen/loginScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _selectedImage;
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  var profileBox = Hive.box<dynamic>('profileBox');
  var categoryBox = Hive.box<dynamic>('categoryBox');
  List categoryKeys = [];

  @override
  void initState() {
    categoryKeys = categoryBox.keys.toList();
    setState(() {});
    super.initState();
  }

  void deleteAllNotes() {
    categoryBox.clear(); // Clear the Hive box
    categoryKeys.clear(); // Clear the note keys list
    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<Settingsscreencontroller>(context);
    return Scaffold(
      backgroundColor: Colorconstants.LightThemeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colorconstants.LightThemeBackgroundColor,
        title: Text(
          'Settings',
          style: TextStyle(
              color: Colorconstants.LightThemeTextColor,
              fontSize: 30,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : AssetImage(
                                Imageconstants.avatar), // default avatar image
                      ),
                      const SizedBox(
                          width: 10), // spacing between avatar and username
                      _isEditing
                          ? Expanded(
                              child: TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )
                          : Text(
                              profileBox.get('username') as String? ?? "Gust",
                              style: TextStyle(
                                color: Colorconstants.LightThemeTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      const Spacer(),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colorconstants.LightThemeTextColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                          onPressed: () async {
                            if (_isEditing) {
                              profileBox.put('username', _nameController.text);
                              if (_selectedImage != null) {
                                settingProvider
                                    .storeImageInNoteBox(_selectedImage!);
                              }

                              _isEditing = false;
                            } else {
                              _nameController.text =
                                  profileBox.get('username') as String? ??
                                      "Gust";
                              _isEditing = true;
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            _isEditing ? Icons.save : Icons.edit,
                            color: Colorconstants.LightThemeBackgroundColor,
                          ),
                        ),
                      ),
                      _isEditing
                          ? IconButton(
                              onPressed: () async {
                                final pickedFile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  _selectedImage = File(pickedFile.path);
                                  setState(() {});
                                }
                              },
                              icon: const Icon(Icons.camera_alt),
                            )
                          : Container(), // Hide camera icon when not editing
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(
                      'General',
                      style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      'Account',
                      style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 18),
                    ),
                    onTap: () {
                      // Handle logout tap
                      //deleteAllNotes();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      'Delete All Category',
                      style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 18),
                    ),
                    onTap: () {
                      deleteAllNotes();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: Text(
                      'About',
                      style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colorconstants.LightThemeTextColor,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colorconstants.LightThemeTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Loginscreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Row(
        children: [
          CircleAvatar(),
          Text(
            'data',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
