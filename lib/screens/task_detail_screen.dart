// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../widgets/task_timer.dart';
import '../providers/task_provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    // Cek apakah task sudah selesai dari provider
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _isCompleted = taskProvider.isTaskCompleted(widget.task.id);
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final taskProvider = Provider.of<TaskProvider>(context);
    final int remainingTime = taskProvider.getTimerForTask(task.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TaskTimer(
              task: task,
              targetDuration: task.targetDurationMinutes,
              initialRemainingTime: remainingTime,
              onTimerFinished: _onTimerFinished,
            ),
            const SizedBox(height: 32),
            if (!_isCompleted)
              ElevatedButton(
                onPressed: _markTaskCompleted,
                child: const Text('Mark as Completed'),
              ),
            if (_isCompleted)
              const Text(
                'Task Completed!',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  void _markTaskCompleted() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    setState(() {
      _isCompleted = true;
    });

    taskProvider.markTaskAsCompleted(widget.task.id);
    Navigator.pop(context);
  }

  void _onTimerFinished() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    setState(() {
      _isCompleted = true;
    });

    taskProvider.markTaskAsCompleted(widget.task.id);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Timer Finished'),
        content: const Text('The timer for this task has ended!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
