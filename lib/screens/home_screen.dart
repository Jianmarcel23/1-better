// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_percent_better/models/achievement.dart';
import 'package:one_percent_better/models/task.dart';
import 'package:one_percent_better/widgets/task_analytics.dart';
import '../widgets/task_list.dart';
import '../widgets/add_task_dialog.dart';
import '../screens/analytics_screen.dart';
import '../providers/task_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Achievement> achievements = Achievement.defaultAchievements;

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('1% Better'),
        actions: [
          IconButton(
            icon: const Icon(Icons.insights),
            onPressed: () => _navigateToAnalytics(tasks),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Tasks',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          TaskList(
            tasks: tasks,
            onDeleteTask: _deleteTask,
            onTaskTap:
                _navigateToTaskDetail, // Callback untuk navigasi ke detail task
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(onAddTask: _addTask),
          );
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTask(Task newTask) {
    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
  }

  void _deleteTask(String taskId) {
    Provider.of<TaskProvider>(context, listen: false).deleteTask(taskId);
  }

  void _navigateToAnalytics(List<Task> tasks) {
    final analytics = TaskAnalytics(
      totalTasksCompleted: tasks.length,
      totalProductiveTime: Duration(
        minutes: tasks.fold(0, (sum, task) => sum + task.targetDurationMinutes),
      ),
      productivityScore: tasks.length * 10.0,
      weeklyPerformance: [],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalyticsScreen(
          analytics: analytics,
          achievements: achievements,
        ),
      ),
    );
  }

  // Fungsi untuk navigasi ke TaskDetailScreen
  void _navigateToTaskDetail(Task task) {
    Navigator.pushNamed(
      context,
      '/task-detail',
      arguments: task, // Kirim task ke TaskDetailScreen
    );
  }
}
