import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_percent_better/main.dart';

void main() {
  group('1% Better App Tests', () {
    testWidgets('App launches and displays home screen',
        (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(MyApp());

      // Verify the app title is displayed
      expect(find.text('1% Better'), findsOneWidget);

      // Verify initial state of tasks
      expect(find.text('No tasks yet. Add a task to get started!'),
          findsOneWidget);
    });

    testWidgets('Add task dialog works correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(MyApp());

      // Tap the add button to open the dialog
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verify dialog is displayed
      expect(find.text('Add New Task'), findsOneWidget);

      // Enter task details
      await tester.enterText(find.byType(TextField).at(0), 'Test Task');
      await tester.enterText(find.byType(TextField).at(1), 'Test Description');
      await tester.enterText(find.byType(TextField).at(2), '30');

      // Tap the add task button
      await tester.tap(find.text('Add Task'));
      await tester.pumpAndSettle();

      // Verify task is added
      expect(find.text('Test Task'), findsOneWidget);
    });

    testWidgets('Task can be deleted via dismissible',
        (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(MyApp());

      // Add a task first
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Enter task details
      await tester.enterText(find.byType(TextField).at(0), 'Delete Test Task');
      await tester.enterText(find.byType(TextField).at(2), '30');

      // Tap the add task button
      await tester.tap(find.text('Add Task'));
      await tester.pumpAndSettle();

      // Verify task is added
      expect(find.text('Delete Test Task'), findsOneWidget);

      // Swipe to delete the task
      await tester.drag(find.text('Delete Test Task'), Offset(-500, 0));
      await tester.pumpAndSettle();

      // Verify task is removed
      expect(find.text('Delete Test Task'), findsNothing);
    });

    testWidgets('Navigate to task detail screen', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(MyApp());

      // Add a task first
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Enter task details
      await tester.enterText(find.byType(TextField).at(0), 'Detail Test Task');
      await tester.enterText(find.byType(TextField).at(2), '30');

      // Tap the add task button
      await tester.tap(find.text('Add Task'));
      await tester.pumpAndSettle();

      // Tap on the task to navigate to detail screen
      await tester.tap(find.text('Detail Test Task'));
      await tester.pumpAndSettle();

      // Verify task details screen
      expect(find.text('Task Details'), findsOneWidget);
      expect(find.text('Detail Test Task'), findsOneWidget);
    });
  });
}
