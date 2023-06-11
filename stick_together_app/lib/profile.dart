import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stick_together_app/edit_profile_page.dart';
import 'package:stick_together_app/login_page.dart';

import 'components/tags_list.dart';
import 'database/CreateTable.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  List<Tag> selectedTags = [];
  //List<Map<String, dynamic>> _descr = []; //Map to keep description;
  String? name;
  late int user_id;
  late String descr, photo, tag;

  Future<bool> _isLoggedIn() async {
    final String? username = await _secureStorage.read(key: 'username');
    final data = await DB.getUser(username!);
    name = username;
    user_id = data[0] as int;
    return username != null;
  }

  Future<void> getDescr() async {
    WidgetsFlutterBinding.ensureInitialized();
    final data = await DB.getDescri();
    setState(() {
      descr = data[1] as String;
      tag = data[2] as String;
      photo = data[3] as String;
      selectedTags = json.decode(tag);
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoggedIn();
    getDescr();
    // DB._initDatabase(); // Initialize the database when the widget is created
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
                  await _secureStorage.delete(key: 'username');
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
            name!,
            style: const TextStyle(fontSize: 30.0),
          )),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(descr,
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
                      children: [
                        for (Tag i in selectedTags)
                          Chip(
                            label: Text(i.name),
                            backgroundColor: i.color,
                          ),
                      ],

                      /*
                      selectedTags.for((element) {
                                      Chip(
                                        label: Text(element.name),
                                        backgroundColor: element.color,
                                      ),
                                      })*/
                      /*
                      const [
                        //item: selectedTags.iterator()
                        Chip(
                          label: Text("Beer"),
                          backgroundColor: Colors.amber,
                        ),
                        Chip(
                          label: Text("Football"),
                          backgroundColor: Colors.green,
                        ),
                        Chip(
                          label: Text("Movies/Cinema"),
                          backgroundColor: Colors.cyan,
                        ),
                        Chip(
                          label: Text("Parties"),
                          backgroundColor: Colors.pink,
                        ),
                        Chip(
                          label: Text("Study Together"),
                          backgroundColor: Colors.purple,
                        ),
                      ],*/
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
