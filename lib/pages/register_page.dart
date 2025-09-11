import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_notes/services/auth_service.dart';
import 'package:tiny_notes/widgets/my_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  late final auth = Provider.of<AuthService>(context, listen: false);

  int currentIndex = 0;
  void increaseIndex() {
    setState(() {
      currentIndex++;
      if (currentIndex > 2) currentIndex = 0;
    });
  }

  void onError(String error) {
    passwordController.clear();
    showSnackbar(context, error);
    setState(() {
      currentIndex = 0;
    });
  }

  void onSuccess() {
    Navigator.pop(context);
    showSnackbar(context, "Created an Account and signup successfully");
  }

  void goToLoginPage() => Navigator.popAndPushNamed(context, "/login");

  void register() async {
    try {
      await auth.createAccountWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await auth.updateDisplayName(
        username: usernameController.text.isEmpty
            ? "User"
            : usernameController.text,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? "Unknown Error Occured");
    }
  }

  Map<int, List<Widget>> get map => {
    0: [
      formTextField(
        controller: emailController,
        hintText: "Email Address",
        isObscure: false,
      ),
      formElevatedButton(
        hintText: "Continue",
        fun: () {
          if (emailController.text.isNotEmpty) increaseIndex();
        },
      ),
    ],
    1: [
      formTextField(
        controller: passwordController,
        hintText: "Password",
        isObscure: true,
      ),
      formElevatedButton(
        hintText: "Confirm",
        fun: () {
          if (passwordController.text.isNotEmpty) increaseIndex();
        },
      ),
    ],
    2: [
      formTextField(
        controller: usernameController,
        hintText: "Username",
        isObscure: false,
      ),
      formElevatedButton(hintText: "Sign Up", fun: register),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentPanel = map[currentIndex]!; // safe, since keys are fixed

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: goToLoginPage,
            label: const Text("Login Instead"),
            icon: const Icon(Icons.login),
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
          ),
        ],
      ),
      body: Center(
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: currentPanel,
            ),
          ),
        ),
      ),
    );
  }
}
