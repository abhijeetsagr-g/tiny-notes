import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:provider/provider.dart';

import 'package:tiny_notes/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tiny_notes/pages/home_page.dart';
import 'package:tiny_notes/pages/login_page.dart';
import 'package:tiny_notes/pages/register_page.dart';

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
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.copyWith(
            titleLarge: TextStyle(fontFamily: 'Schoolbell', fontSize: 20),
          ),
        ),
        themeMode: ThemeMode.dark,
        title: "Tiny Notes",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
        },
      ),
    ),
  );
}
