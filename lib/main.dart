import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aurora_assistant/app.dart';
import 'package:aurora_assistant/routes.dart';
import 'package:aurora_assistant/theme.dart';
import 'package:aurora_assistant/services/auth_service.dart';
import 'package:aurora_assistant/services/task_service.dart';
import 'package:aurora_assistant/services/voice_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => TaskService()),
        Provider(create: (_) => VoiceService()),
      ],
      child: const AuroraApp(),
    ),
  );
}

class AuroraApp extends StatelessWidget {
  const AuroraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AURORA Assistant',
      debugShowCheckedModeBanner: false,
      theme: auroraTheme,
      initialRoute: AppRoutes.dashboard,
      onGenerateRoute: AppRoutes.generateRoute,
      routes: AppRoutes.routes,
    );
  }
}
