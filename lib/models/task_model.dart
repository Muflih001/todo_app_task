import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String task;

  Task({required this.task});
}
