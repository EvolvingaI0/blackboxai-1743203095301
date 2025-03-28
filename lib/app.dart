import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:aurora_assistant/features/dashboard/dashboard_page.dart';
import 'package:aurora_assistant/services/auth_service.dart';
import 'package:aurora_assistant/features/auth/auth_page.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Firebase initialization failed'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<User?>(
            stream: Provider.of<AuthService>(context, listen: false)
                .authStateChanges,
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.active) {
                return userSnapshot.hasData
                    ? const DashboardPage()
                    : const AuthPage();
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
