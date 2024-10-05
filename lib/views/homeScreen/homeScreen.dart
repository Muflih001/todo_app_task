import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_task/utils/colorConstants.dart';
import 'package:todo_app_task/utils/imageConstants.dart';
import 'package:todo_app_task/views/homeScreen/widgets/categoryCard.dart';
import 'package:todo_app_task/views/settingsScreen/settingsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box('taskBox');
  List taskKeys = [];
  List categoryKeys = [];

  Uint8List? _profile;

  var profileBox = Hive.box<dynamic>('profileBox');
  var categoryBox = Hive.box<dynamic>('categoryBox');

  @override
  void initState() {
    taskKeys = taskBox.keys.toList();
    categoryKeys = categoryBox.keys.toList();
    setState(() {});
    super.initState();
    _loadProfileAndUsername();
  }

  _loadProfileAndUsername() async {
    _profile = profileBox.get('profile') as Uint8List?;
    // _name = profileBox.get('username') as String?;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category',
          style: TextStyle(
              color: Colorconstants.LightThemeTextColor,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colorconstants.LightThemeBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Builder(
            builder: (context) => InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ));
              },
              child: CircleAvatar(
                radius: 35,
                backgroundImage: _profile != null
                    ? MemoryImage(_profile!)
                    : AssetImage(Imageconstants.avatar),
              ),
            ),
          ),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colorconstants.LightThemeTextColor,
            size: 30,
          )
        ],
      ),
      backgroundColor: Colorconstants.LightThemeBackgroundColor,
      body: SafeArea(
        child: Container(
          color: Colorconstants.LightThemeBackgroundColor,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Manage Your\nDaily Task',
                    style: TextStyle(
                        color: Colorconstants.LightThemeTextColor,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 150),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Add Button at the top
                          return GestureDetector(
                            onTap: () {
                              _showAddCategoryDialog();
                            },
                            child: Card(
                              elevation: 10,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 50,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          );
                        }

                        final category =
                            categoryBox.get(categoryKeys[index - 1]);

                        return CategoryCard(
                          onDelete: () {
                            categoryBox.delete(categoryKeys[index - 1]);
                            categoryKeys = categoryBox.keys.toList();
                            setState(() {});
                          },
                          category: category['title'],
                          emoji: category['emoji'],
                        );
                      },
                      itemCount: categoryKeys.length + 1)),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCategoryDialog() {
    TextEditingController _categoryController = TextEditingController();
    TextEditingController _emojiController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colorconstants.LightThemeBackgroundColor,
          title: const Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emojiController,
                decoration: const InputDecoration(hintText: 'Enter emoji'),
              ),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(hintText: 'Enter category name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  categoryBox.add({
                    'title': _categoryController.text,
                    'emoji': _emojiController.text,
                  });
                });
                categoryKeys = categoryBox.keys.toList();
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
