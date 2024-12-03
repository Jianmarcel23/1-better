import 'package:flutter/material.dart';
import 'package:one_percent_better/models/task.dart';
import 'package:one_percent_better/screens/task_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:one_percent_better/providers/task_provider.dart';
import 'package:one_percent_better/screens/home_screen.dart';
import 'package:one_percent_better/screens/welcome_screen.dart'; // Tambahkan import welcome screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'One Percent Better',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // Tambahkan konfigurasi tema tambahan jika diperlukan
        ),
        initialRoute: '/welcome', // Ubah initial route ke welcome
        routes: {
          '/welcome': (context) => WelcomePage(), // Tambahkan rute welcome
          '/home': (context) => HomeScreen(), // Tambahkan rute home
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/task-detail') {
            final Task task = settings.arguments as Task;
            return MaterialPageRoute(
              builder: (context) => TaskDetailScreen(task: task),
            );
          }
          return null;
        },
      ),
    );
  }
}
