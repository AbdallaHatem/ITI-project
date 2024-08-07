import 'package:flutter/material.dart';
import 'package:shopping_app/database/database_handler.dart';
import 'package:shopping_app/database/tables_classes.dart';
import 'package:shopping_app/login/shared_pref.dart';
import 'package:shopping_app/login/login_page.dart';

// Function to get user data
Future<user?> getUserData(DataBaseHandler db, int userId) async {
  return await db.getUserByID(userId);
}

// Function to handle logout
Future<void> handleLogout(BuildContext context) async {
  await sharedPref().logOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    (route) => false,
  );
}

// Function to build text fields
Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField, bool isObsecurePassword, Function() onEyeIconPressed) {
  return Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: TextField(
      obscureText: isPasswordTextField ? isObsecurePassword : false,
      decoration: InputDecoration(
        suffixIcon: isPasswordTextField
            ? IconButton(
                icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                onPressed: onEyeIconPressed,
              )
            : null,
        contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ),
  );
}
