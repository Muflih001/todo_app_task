import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settingsscreencontroller with ChangeNotifier {
  var profileBox = Hive.box('profileBox');
  void storeImageInNoteBox(File image) async {
    Uint8List imageBytes = await image.readAsBytes();
    profileBox.put('profile', imageBytes);
    notifyListeners();
  }

  void storeUserNameInNoteBox(String text) {
    profileBox.put('username', text);

    notifyListeners();
  }

  void loadProfileAndUsername() async {
    profileBox.get(
      'profile',
    ) as Uint8List?;
    profileBox.get(
      'username',
    ) as String?;
    notifyListeners();
  }
}
