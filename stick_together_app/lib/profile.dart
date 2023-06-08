import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stick_together_app/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ));
                },
                icon: Icon(Icons.edit))
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            radius: 65.0,
            backgroundImage: null,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: Text(
            "John Doe",
            style: TextStyle(fontSize: 30.0),
          )),
          SizedBox(
            height: 20.0,
          ),
          Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
              textAlign: TextAlign.justify),
        ]),
        SizedBox(
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
                      ],
                    ),
                  ]),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Column(
          children: [
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
