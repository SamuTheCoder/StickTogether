import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stick_together_app/UserModel.dart';
import 'package:stick_together_app/components/textfield.dart';
import 'package:stick_together_app/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final String username = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      String profileDescription = 'Default Description';
      List<int>? selectedTags;

      if (_passwordController.text != _repeatPasswordController.text) {
        throw 'Password Mismatch';
      }
      try {
        List<String> friend = [];
        final UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        final UserModel user = UserModel(
            username: username,
            email: email,
            password: password,
            profileDescription: profileDescription,
            selectedTags: selectedTags,
            friends: friend);

        final CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');
        await usersCollection.doc(userCredential.user!.uid).set(user.toMap());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User Registered'),
          duration: const Duration(seconds: 2),
        ));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (error) {
        String errorMessage;

        if (error == 'Password Mismatch')
          errorMessage = 'Password Mismatch';
        else
          errorMessage = "An error has occured";

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 2),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text("StickTogether",
                  style: TextStyle(color: Colors.amber, fontSize: 30)),
              const SizedBox(
                height: 50,
              ),
              //Introduction
              const Text("Join us :)", style: TextStyle(fontSize: 23)),
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
                    controller: _nameController,
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
                      hintText: "Name",
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
                    controller: _emailController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email';
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
                      hintText: "Email",
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
                    controller: _repeatPasswordController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value != _passwordController.text) {
                        return 'Passwords do not match';
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
                      hintText: "Repeat Password",
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              SizedBox(
                width: 90,
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    onPressed: () {
                      _registerUser();
                    },
                    child: const Text("Sign up")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
