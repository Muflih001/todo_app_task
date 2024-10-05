
import 'package:flutter/material.dart';
import 'package:todo_app_task/utils/colorConstants.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});
  final String task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          _isSelected
              ? (Icons.radio_button_checked)
              : (Icons.radio_button_unchecked),
          color: Colors.green,
        ),
        onPressed: () {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
      ),
      title: Text(
        widget.task,
        style:
            TextStyle(fontSize: 18, color: Colorconstants.LightThemeTextColor),
      ),
    );
  }
}
