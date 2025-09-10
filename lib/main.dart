import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_notes/firebase_options.dart';
import 'package:tiny_notes/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (context) => AuthService()),
        StreamProvider<User?>(
          create: (context) => AuthService().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Main()),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
