import 'package:flutter/material.dart';
import 'package:stick_together_app/home_page.dart';
import 'package:stick_together_app/login_page.dart';

class CheckAuth extends StatelessWidget {
  final bool userAuthenticated = false;
  @override
  Widget build(BuildContext context) {
    return userAuthenticated ? HomePage() : LoginPage();
  }
}
