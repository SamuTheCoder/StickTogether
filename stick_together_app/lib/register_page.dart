import 'package:flutter/material.dart';
import 'package:stick_together_app/components/textfield.dart';

class RegisterPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Text("StickTogether",
                style: TextStyle(color: Colors.amber, fontSize: 30)),
            SizedBox(
              height: 50,
            ),
            //Introduction
            Text("Join us :)", style: TextStyle(fontSize: 23)),
            //fill texts
            SizedBox(
              height: 50,
            ),
            DefaultTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false),
            const SizedBox(
              height: 10,
            ),
            DefaultTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false),
            const SizedBox(
              height: 10,
            ),
            DefaultTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true),

            const SizedBox(
              height: 10,
            ),
            DefaultTextField(
                controller: repeatPasswordController,
                hintText: 'Repeat Password',
                obscureText: true),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 90,
              height: 40,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  onPressed: () {},
                  child: const Text("Sign up")),
            ),
          ],
        ),
      ),
    );
  }
}
