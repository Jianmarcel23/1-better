// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  final Map<String, int> _taskTimers = {};
  final Map<String, bool> _completedTasks = {};

  List<Task> get tasks => _tasks;

  TaskProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Muat timer
      _taskTimers.clear();
      for (var task in _tasks) {
        final savedTimer = prefs.getInt('timer_${task.id}') ?? 0;
        if (savedTimer > 0) {
          _taskTimers[task.id] = savedTimer;
        }
      }

      // Muat status completed
      _completedTasks.clear();
      for (var task in _tasks) {
        final isCompleted = prefs.getBool('completed_${task.id}') ?? false;
        _completedTasks[task.id] = isCompleted;
      }

      notifyListeners();
    } catch (e) {}
  }

  int getTimerForTask(String taskId) {
    return _taskTimers[taskId] ?? 0;
  }

  Future<void> setTimerForTask(String taskId, int remainingTime) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _taskTimers[taskId] = remainingTime;
      await prefs.setInt('timer_$taskId', remainingTime);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> resetTimerForTask(String taskId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _taskTimers.remove(taskId);
      await prefs.remove('timer_$taskId');
      notifyListeners();
    } catch (e) {}
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _tasks.removeWhere((task) => task.id == taskId);
      _taskTimers.remove(taskId);
      _completedTasks.remove(taskId);

      await prefs.remove('timer_$taskId');
      await prefs.remove('completed_$taskId');

      notifyListeners();
    } catch (e) {}
  }

  Future<void> markTaskAsCompleted(String taskId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _completedTasks[taskId] = true;
      _taskTimers.remove(taskId);

      await prefs.setBool('completed_$taskId', true);
      await prefs.remove('timer_$taskId');

      notifyListeners();
    } catch (e) {}
  }

  bool isTaskCompleted(String taskId) {
    return _completedTasks[taskId] ?? false;
  }

  // Tambahan method untuk menangani edge case
  void clearAllData() {
    _tasks.clear();
    _taskTimers.clear();
    _completedTasks.clear();
    notifyListeners();
  }
}
