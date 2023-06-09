import 'package:flutter/material.dart';
import 'package:stick_together_app/components/textfield.dart';
import 'package:stick_together_app/home_page.dart';

import 'database/CreateTable.dart';

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

  //RegisterPage({super.key});
  List<Map<String, dynamic>> _account = []; //Map to keep user;
  bool _isloading = true;

  void _refreshaAccount() async {
    //final database = await DB._initDatabase();
    final data = await DB.getAccounts();
    setState(() {
      _account = data;
      _isloading = false;
    });
  }

  Future<bool> _addUser(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    final data = await DB.getUser(_nameController.text);
    //print("--------------------------------------- oirrrrrrrrrrrr");
    if (data.isEmpty) {
      await DB.createAccount(_nameController.text, _emailController.text,
          _passwordController.text, '000000000');
      _refreshaAccount();
      //print("User in A Account! is ${_account.length}");
      return true;
    } else {
      //print("User in A Account! oirrrrrrrrrrrr");
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool done = await _addUser(context);
                        //print('oiiiiiiiiiiiiiiiiiiiiiiii---- ' + done.toString());
                        if (done) {
                          //final localContext = context;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (localContext) => HomePage()));
                        } else {
                          _passwordController.clear();
                          _repeatPasswordController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('User already exists'),
                              duration: Duration(seconds: 2)));
                        }
                      }
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
