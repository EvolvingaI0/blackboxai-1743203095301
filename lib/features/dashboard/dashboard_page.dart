import 'package:flutter/material.dart';
import 'package:aurora_assistant/components/aurora_avatar.dart';
import 'package:aurora_assistant/routes.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AURORA Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          AuroraAvatar(
            onVoiceCommand: (command) {
              switch (command) {
                case 'tasks':
                  context.push(AppRoutes.tasks);
                  break;
                case 'calendar':
                  context.push(AppRoutes.calendar);
                  break;
              }
            },
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildFeatureCard('Tarefas', Icons.task, () => context.push(AppRoutes.tasks)),
                _buildFeatureCard('Calendário', Icons.calendar_today, () => context.push(AppRoutes.calendar)),
                _buildFeatureCard('Projetos', Icons.assignment, () => context.push(AppRoutes.projects)),
                _buildFeatureCard('Notas', Icons.note, () => context.push(AppRoutes.notes)),
                _buildFeatureCard('Hábitos', Icons.trending_up, () => context.push(AppRoutes.habits)),
                _buildFeatureCard('Finanças', Icons.attach_money, () => context.push(AppRoutes.finance)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
