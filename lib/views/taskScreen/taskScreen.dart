import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_task/models/task_model.dart';
import 'package:todo_app_task/utils/colorConstants.dart';
import 'package:todo_app_task/views/taskScreen/widgets/taskCard.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.category});
  final String category;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController _taskController = TextEditingController();
  var taskBox = Hive.box('taskBox');
  Map<String, List<Task>> tasks = {};

  @override
  void initState() {
    if (taskBox.get('tasks') != null) {
      tasks = taskBox.get('tasks');
    } else {
      tasks = {};
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.category,
            style: TextStyle(
                color: Colorconstants.LightThemeTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colorconstants.LightThemeTextColor,
                  size: 30,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colorconstants.LightThemeTextColor,
          shape: CircleBorder(),
          onPressed: () {
            _showCustomDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colorconstants.LightThemeBackgroundColor,
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              if (tasks[widget.category] != null) {
                final task = tasks[widget.category]![index];
                return TaskCard(
                  task: task.task,
                );
              } else {
                return Container();
              }
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
            itemCount: tasks[widget.category] != null
                ? tasks[widget.category]!.length
                : 0));
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Type your task...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        if (tasks[widget.category] == null) {
                          tasks[widget.category] = [Task(task: text)];
                        } else {
                          tasks[widget.category]!.add(Task(task: text));
                        }
                        taskBox.put('tasks', tasks);
                      }
                      _taskController.clear();
                      setState(() {});
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
