// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stick_together_app/components/textfield.dart';
import 'package:stick_together_app/home_page.dart';
import 'package:stick_together_app/register_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'database/CreateTable.dart';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<bool> _login(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    final data =
        await DB.getAccount(_usernameController.text, _passwordController.text);
    print('AQUIIIIIIIIII\n');
    print(data);
    await _secureStorage.write(
        key: 'username', value: _usernameController.text);
    // ignore: unrelated_type_equality_checks
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

/*
final plainText = 'YOUR_PASSWORD';
final key = Key.fromUtf8 ('my 32 length key................');
final iv = IV.fromLength (16);
final encrypter = Encrypter (AES (key));
final encrypted = encrypter.encrypt (plainText, iv: iv);
final decrypted = encrypter.decrypt (encrypted, iv: iv);
print (decrypted); // YOUR_PASSWORD
print (encrypted.base64);// YOUR_ENCRYPTED_STRING

var bytes = utf8.encode("password"); // data being hashed

  var digest = sha256.convert(bytes);

  print("Digest as bytes: ${digest.bytes}");
  print("Digest as hex string: $digest");
*/
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // DB._initDatabase(); // Initialize the database when the widget is created
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Text("StickTogether",
                style: TextStyle(color: Colors.amber, fontSize: 30)),
            const SizedBox(
              height: 50,
            ),
            //Introduction
            const Text("Welcome Back :P", style: TextStyle(fontSize: 23)),
            //fill texts
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  obscureText: false,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    hintText: "Username",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  obscureText: true,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    hintText: "Password",
                  ),
                ),
              ),
            ),

            //forgot password
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text("forgot password")],
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool done = await _login(context);
                          if (done) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (localContext) => HomePage()));
                          } else {
                            _passwordController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Username or password is not correct!'),
                                duration: Duration(seconds: 2)));
                          }
                        }
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
      )),
    );
  }
}
