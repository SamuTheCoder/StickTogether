// ignore_for_file: no_logic_in_create_state, use_build_context_synchronously

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:path/path.dart';
import 'package:stick_together_app/edit_profile_page.dart';
import 'package:stick_together_app/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'UserModel.dart';
import 'login_page.dart';

import 'components/tags_list.dart';

class FriendProfilePage extends StatefulWidget {
  const FriendProfilePage({super.key, required this.userId});
  final String userId;

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  //_FriendProfilePageState(String userId);
  List<Tag> selectedTags = [];
  //String user_Id;
  //List<Map<String, dynamic>> _descr = []; //Map to keep description;
  String? name;
  late int user_id;
  late String? descr = '';
  late List<String>? friend = [];
  List<String> amigo = [];
  Map<int, String> myfriend = {};

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // DB._initDatabase(); // Initialize the database when the widget is created
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get();
        if (snapshot.exists) {
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;
          setState(() {
            name = userData['username'];
            descr = userData['profileDescription'];
            amigo = List<String>.from(userData['friends']);

            //friend = userData['friends'];
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

  Future<void> readFriend() async {
    for (var i = 0; i < amigo.length; i++) {
      String userIdF = amigo[i];
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userIdF)
          .get();
      String usName = '';
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        if (mounted) {
          setState(() {
            usName = userData['username'];
          });
        }
      }
      myfriend.addAll({i: usName});
    }
  }

  Future<void> addFriend(BuildContext context) async {
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
            friend = List<String>.from(userData['friends']);
            if (!friend!.contains(widget.userId)) {
              friend!.add(widget.userId);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('He is your friend'),
                duration: Duration(seconds: 2),
              ));
            }
          });
          List<int>? selectedTagIndexes =
              List<int>.from(userData['selectedTags']);

          final UserModel upUser = UserModel(
              username: userData['username'],
              email: userData['email'],
              password: userData['password'],
              profileDescription: userData['profileDescription'],
              selectedTags: selectedTagIndexes,
              friends: friend,
              userId: user.uid);

          final CollectionReference usersCollection =
              FirebaseFirestore.instance.collection('users');
          await usersCollection.doc(user.uid).update(upUser.toMap());
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Friend Added'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print('Could not get user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //var item;
    readFriend();
    return Container(
      color: Colors.grey,
      margin: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Align(
              alignment: Alignment.topCenter,
              child: ProfilePicture(
                name: name ?? 'Loading',
                fontsize: 30,
                radius: 35,
              )),
          const SizedBox(
            height: 20,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
                child: Text(
              name ?? 'Loading',
              style: const TextStyle(fontSize: 30.0),
            )),
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: Text(descr ?? 'Loading',
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                  textAlign: TextAlign.justify),
            ),
          ]),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 10.0,
                        direction: Axis.horizontal,
                        children: selectedTags.map((tag) {
                          return Material(
                            child: Chip(
                              label: Text(tag.name),
                              backgroundColor: tag.color,
                            ),
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
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                "Friends: ",
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              const SizedBox(
                height: 19.0,
              ),
              /*
              Text(
                amigo ?? "10",
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),*/

              Wrap(
                spacing: 10.0,
                direction: Axis.horizontal,
                children: myfriend.entries.map((k) {
                  return Material(
                    child: Chip(
                      label: Text(k.value),
                      backgroundColor: Colors.blue,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber)),
                onPressed: () {
                  addFriend(context);
                },
                child: const Text("Add Friend")),
          ),
        ]),
      ),
    );
  }
}
