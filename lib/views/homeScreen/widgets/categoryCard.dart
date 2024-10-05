
import 'package:flutter/material.dart';
import 'package:todo_app_task/utils/colorConstants.dart';
import 'package:todo_app_task/views/taskScreen/taskScreen.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final String emoji;
  final VoidCallback onDelete; // Callback for delete action

  CategoryCard({
    required this.category,
    required this.emoji,
    required this.onDelete, // Pass delete callback from parent
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskScreen(category: category),
            ));
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    emoji,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'task',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.delete,
                      color: Colorconstants.LightThemeTextColor),
                  onPressed: onDelete, // Trigger the delete action
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
