import 'package:flutter/material.dart';
import 'package:aurora_assistant/features/dashboard/dashboard_page.dart';
import 'package:aurora_assistant/features/tasks/task_list.dart';
import 'package:aurora_assistant/features/calendar/calendar_page.dart';
import 'package:aurora_assistant/features/projects/project_list.dart';
import 'package:aurora_assistant/features/notes/note_list.dart';
import 'package:aurora_assistant/features/habits/habit_tracker.dart';
import 'package:aurora_assistant/features/finance/expense_tracker.dart';
import 'package:aurora_assistant/features/settings/settings_page.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String tasks = '/tasks';
  static const String calendar = '/calendar';
  static const String projects = '/projects';
  static const String notes = '/notes';
  static const String habits = '/habits';
  static const String finance = '/finance';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case tasks:
        return MaterialPageRoute(builder: (_) => const TaskListPage());
      case calendar:
        return MaterialPageRoute(builder: (_) => const CalendarPage());
      case projects:
        return MaterialPageRoute(builder: (_) => const ProjectListPage());
      case notes:
        return MaterialPageRoute(builder: (_) => const NoteListPage());
      case habits:
        return MaterialPageRoute(builder: (_) => const HabitTrackerPage());
      case finance:
        return MaterialPageRoute(builder: (_) => const ExpenseTrackerPage());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Map<String, WidgetBuilder> get routes {
    return {
      dashboard: (context) => const DashboardPage(),
      tasks: (context) => const TaskListPage(),
      calendar: (context) => const CalendarPage(),
      projects: (context) => const ProjectListPage(),
      notes: (context) => const NoteListPage(),
      habits: (context) => const HabitTrackerPage(),
      finance: (context) => const ExpenseTrackerPage(),
      settings: (context) => const SettingsPage(),
    };
  }
}