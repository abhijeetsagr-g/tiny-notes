import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool showFirstForm = true;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    void onSuccess() {
      Navigator.pop(context);
      showSnackbar(context, "Logged In Successfully");
    }

    void onError(String message) {
      showSnackbar(context, message);
      showFirstForm = true;
    }

    void login() async {
      try {
        await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        onSuccess();
      } on FirebaseAuthException catch (e) {
        setState(() {
          onError(e.message ?? "Something Unexpected Happened");
        });
      }
    }

    List<Widget> emailForm() {
      return [
        formTextField(
          controller: emailController,
          hintText: "Email Address",
          isObscure: false,
        ),
        formElevatedButton(
          hintText: "Continue",
          fun: () {
            if (emailController.text.isNotEmpty) {
              setState(() {
                showFirstForm = false;
              });
            }
          },
        ),
      ];
    }

    List<Widget> passwordForm() {
      return [
        formTextField(
          controller: passwordController,
          hintText: "Password",
          isObscure: true,
        ),
        formElevatedButton(hintText: "Login", fun: login),
      ];
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: showFirstForm ? emailForm() : passwordForm(),
            ),
          ),
        ),
      ),
    );
  }
}
