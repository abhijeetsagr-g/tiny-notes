import 'package:flutter/material.dart';

Widget formTextField({
  required TextEditingController controller,
  required String hintText,
  required bool isObscure,
}) {
  return TextField(
    controller: controller,
    obscureText: isObscure,
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
    ),
  );
}

Widget formElevatedButton({required String hintText, required Function fun}) {
  return ElevatedButton(
    onPressed: () => fun(),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(),
    ),
    child: Center(child: Text(hintText)),
  );
}

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(),
      content: Text(content),
    ),
  );
}
