import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) onDeleteTask;

  const TaskList(
      {super.key,
      required this.tasks,
      required this.onDeleteTask,
      required void Function(Task task) onTaskTap});

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              'No tasks yet. Add a task to get started!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.id),
                background: Container(color: Colors.red),
                onDismissed: (direction) => onDeleteTask(task.id),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(
                    '${task.targetDurationMinutes} menit',
                  ),
                  onTap: () {
                    // Navigasi ke TaskDetailScreen dan kirim task sebagai argumen
                    Navigator.pushNamed(
                      context,
                      '/task-detail',
                      arguments: task, // Mengirim task sebagai argumen
                    );
                  },
                ),
              );
            },
          );
  }
}
