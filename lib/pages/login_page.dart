import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_notes/services/auth_service.dart';
import 'package:tiny_notes/widgets/my_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showFirstForm = true;
  late final AuthService auth = Provider.of<AuthService>(
    context,
    listen: false,
  );

  void goToRegisterPage() {
    Navigator.popAndPushNamed(context, '/register');
  }

  void _onSuccess() {
    showSnackbar(context, "Logged In Successfully");
    Navigator.pop(context);
  }

  void _onError(String message) {
    passwordController.clear();
    setState(() {
      showSnackbar(context, message);
      showFirstForm = true;
    });
  }

  Future<void> _login() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      _onSuccess();
    } on FirebaseAuthException catch (e) {
      _onError(e.message ?? "Something unexpected happened");
    }
  }

  Widget _emailForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        formTextField(
          controller: emailController,
          hintText: "Email Address",
          isObscure: false,
        ),
        formElevatedButton(
          hintText: "Continue",
          fun: () {
            if (emailController.text.isNotEmpty) {
              setState(() => showFirstForm = false);
            }
          },
        ),
      ],
    );
  }

  Widget _passwordForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        formTextField(
          controller: passwordController,
          hintText: "Password",
          isObscure: true,
        ),
        formElevatedButton(hintText: "Login", fun: _login),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
            onPressed: goToRegisterPage,
            icon: Icon(Icons.app_registration),
            label: Text("Register Instead?"),
          ),
        ],
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: showFirstForm ? _emailForm() : _passwordForm(),
          ),
        ),
      ),
    );
  }
}
