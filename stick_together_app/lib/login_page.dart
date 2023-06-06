import 'package:flutter/material.dart';
import 'package:stick_together_app/components/textfield.dart';
import 'package:stick_together_app/home_page.dart';
import 'package:stick_together_app/register_page.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginPage({super.key});

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
            Text("Welcome Back :P", style: TextStyle(fontSize: 23)),
            //fill texts
            SizedBox(
              height: 50,
            ),
            DefaultTextField(
                controller: _usernameController,
                hintText: 'Username',
                obscureText: false),

            const SizedBox(
              height: 10,
            ),
            DefaultTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true),

            //forgot password
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text("forgot password")],
              ),
            ),
            //row
            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //login button
                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: const Text("Sign In")),
                ),
                const SizedBox(
                  width: 5,
                ),
                //register button
                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: const Text("Sign Up")),
                ),
              ],
            ),

            //login with google
            SizedBox(
              height: 200,
            ),
            SizedBox(
              width: 220,
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {},
                      icon: Image.asset('images/google.png'),
                      label: const Text(
                        "Sign in with Google",
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
