// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stick_together_app/components/tags_list.dart';
import 'package:stick_together_app/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _descriptionController = TextEditingController();
  final _userController = TextEditingController();
  final _phoneController = TextEditingController();
  List<Tag> selectedTags = [];
  //List<Map<String, dynamic>> _descr = []; //Map to keep description;
  String? name;
  late int user_id;
  //late String descr, photo, tag;
  //final descr = _descriptionController.text;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // DB._initDatabase(); // Initialize the database when the widget is created
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;
          setState(() {
            _descriptionController.text = userData['profileDescription'];
            List<int>? selectedTagIndexes =
                List<int>.from(userData['selectedTags']);
            selectedTags =
                selectedTagIndexes.map((index) => tagsList[index]).toList();
          });
        }
      }
    } catch (e) {
      print('Could not get user data: $e');
    }
  }

  Future<void> updateUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String description = _descriptionController.text;
        List<int> selectedTagsIndexes =
            selectedTags.map((tag) => tagsList.indexOf(tag)).toList();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profileDescription': description,
          'selectedTags': selectedTagsIndexes,
        });
      }
      fetchUserData();
    } catch (e) {}
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 8,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: TextField(
                  controller: _descriptionController,
                  onEditingComplete: () {
                    updateUserData();
                  },
                  obscureText: false,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tags:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Wrap(
                spacing: 8,
                children: tagsList.map((tag) {
                  bool isSelected = selectedTags.contains(tag);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InputChip(
                      label: Text(tag.name),
                      selected: isSelected,
                      selectedColor: tag.color,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            if (!selectedTags.contains(tag)) {
                              selectedTags.add(tag);
                            }
                          } else {
                            selectedTags.remove(tag);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
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
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
              ),
              SizedBox(
                width: 90,
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    onPressed: () async {
                      updateUserData();
                      Navigator.pop(context);
                    },
                    child: const Text("Save")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
