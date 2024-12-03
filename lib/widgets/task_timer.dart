// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskTimer extends StatefulWidget {
  final Task task;
  final int targetDuration;
  final int initialRemainingTime;
  final VoidCallback onTimerFinished;

  const TaskTimer({
    Key? key,
    required this.task,
    required this.targetDuration,
    required this.initialRemainingTime,
    required this.onTimerFinished,
  }) : super(key: key);

  @override
  _TaskTimerState createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> with WidgetsBindingObserver {
  late int _remainingTime;
  Timer? _timer;
  late TaskProvider _taskProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _taskProvider = Provider.of<TaskProvider>(context, listen: false);

    _remainingTime = widget.initialRemainingTime > 0
        ? widget.initialRemainingTime
        : widget.targetDuration * 60;

    _startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Simpan remaining time saat aplikasi di background
      _taskProvider.setTimerForTask(widget.task.id, _remainingTime);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });

        _taskProvider.setTimerForTask(widget.task.id, _remainingTime);
      } else {
        timer.cancel();
        widget.onTimerFinished();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _taskProvider.setTimerForTask(widget.task.id, _remainingTime);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _remainingTime ~/ 60;
    final seconds = _remainingTime % 60;

    return Column(
      children: [
        Text(
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: _remainingTime / (widget.targetDuration * 60),
        ),
      ],
    );
  }
}
