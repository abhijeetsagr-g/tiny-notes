import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_notes/services/auth_service.dart';
import 'package:tiny_notes/widgets/my_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final user = Provider.of<User?>(context);
    bool isSignedIn = user != null;

    void logout() async {
      await auth.signOut();
      showSnackbar(context, "Signed Out");
    }

    List<Widget> actionOnLoggedOut() {
      return [
        TextButton.icon(
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          icon: Icon(Icons.login),
          label: Text("Login"),
        ),
      ];
    }

    List<Widget> actionOnLoggedIn() {
      return [
        IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever)),
        IconButton(onPressed: logout, icon: Icon(Icons.logout)),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Tiny Notes", style: TextStyle(fontSize: 24)),
        actions: isSignedIn ? actionOnLoggedIn() : actionOnLoggedOut(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
