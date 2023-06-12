import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stick_together_app/edit_profile_page.dart';
import 'package:stick_together_app/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

import 'components/tags_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Tag> selectedTags = [];
  //List<Map<String, dynamic>> _descr = []; //Map to keep description;
  String? name;
  late int user_id;
  late String? descr = '';

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
            name = userData['username'];
            descr = userData['profileDescription'];
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

  @override
  Widget build(BuildContext context) {
    //var item;
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ));
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () async {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            radius: 65.0,
            backgroundImage: null,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: Text(
            name ?? 'Loading',
            style: const TextStyle(fontSize: 30.0),
          )),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(descr ?? 'Loading',
                //style: const TextStyle(fontSize: 30.0),
                textAlign: TextAlign.justify),
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      direction: Axis.horizontal,
                      children: selectedTags.map((tag) {
                        return Chip(
                          label: Text(tag.name),
                          backgroundColor: tag.color,
                        );
                      }).toList(),
                    ),
                  ]),
            )
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Column(
          children: const [
            Text(
              "Friends: ",
              style: TextStyle(fontSize: 25.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "19",
              style: TextStyle(fontSize: 25.0),
            )
          ],
        ),
      ]),
    );
  }
}
