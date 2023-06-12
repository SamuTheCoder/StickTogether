// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stick_together_app/components/tags_list.dart';

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

    // DB._initDatabase(); // Initialize the database when the widget is created
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15.0),
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
              height: 20,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: _userController,
                  validator: (value) {
                    //Verificar se o user já exite!
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username if you would like edit it!';
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
                    hintText: "User Name",
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
                  controller: _phoneController,
                  obscureText: false,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    hintText: "phone",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
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
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Save")),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChips() => Chip(label: Text("bla"));
}
