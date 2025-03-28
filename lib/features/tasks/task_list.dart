import 'package:flutter/material.dart';
import 'package:aurora_assistant/models/task.dart';
import 'package:aurora_assistant/services/task_service.dart';
import 'package:aurora_assistant/services/auth_service.dart';
import 'package:aurora_assistant/features/tasks/task_dialog.dart';
import 'package:provider/provider.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late final TaskService _taskService;
  late final String _userId;
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _userId = authService.currentUser!.uid;
    _taskService = TaskService();
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      _tasksFuture = _taskService.getTasks(_userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewTask,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTasks,
          ),
        ],
      ),
      body: FutureBuilder<List<Task>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final tasks = snapshot.data ?? [];
          if (tasks.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa encontrada'));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.id),
                background: Container(color: Colors.red),
                onDismissed: (direction) => _deleteTask(task),
                child: Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) => _toggleTaskCompletion(task),
                    ),
                    title: Text(task.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.description),
                        Text(
                          'Prazo: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: _buildPriorityIndicator(task.priority),
                    onTap: () => _editTask(task),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPriorityIndicator(Priority priority) {
    Color color;
    switch (priority) {
      case Priority.high:
        color = Colors.red;
        break;
      case Priority.medium:
        color = Colors.orange;
        break;
      case Priority.low:
        color = Colors.green;
        break;
    }
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  void _addNewTask() {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        onSave: (newTask) async {
          try {
            await _taskService.addTask(_userId, newTask);
            _loadTasks();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Falha ao criar tarefa: $e')),
            );
          }
        },
      ),
    );
  }

  void _editTask(Task task) {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        task: task,
        onSave: (updatedTask) async {
          try {
            await _taskService.updateTask(_userId, updatedTask);
            _loadTasks();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Falha ao atualizar tarefa: $e')),
            );
          }
        },
      ),
    );
  }

  Future<void> _deleteTask(Task task) async {
    try {
      await _taskService.deleteTask(_userId, task.id);
      _loadTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao deletar tarefa: $e')),
      );
    }
  }

  Future<void> _toggleTaskCompletion(Task task) async {
    try {
      await _taskService.toggleTaskCompletion(
        _userId,
        task.id,
        !task.isCompleted,
      );
      _loadTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao atualizar tarefa: $e')),
      );
    }
  }
}
