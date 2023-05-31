import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Text> notes = [
      Text("I'mma be at Convívio at 2pm"),
      Text("I'mma be at Convívio at 2pm"),
      Text("I'mma be at Convívio at 2pm"),
      Text("I'mma be at Convívio at 2pm"),
      Text("I'mma be at Convívio at 2pm"),
    ];
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth * 0.8;
        return Container(
          margin: const EdgeInsets.all(15.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: null,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Center(
                            child: Text(
                          "John Doe",
                          style: TextStyle(fontSize: 30.0),
                        )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                            textAlign: TextAlign.justify),
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
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
                            const Chip(
                              label: Text("Beer"),
                              backgroundColor: Colors.amber,
                            ),
                            const Chip(
                              label: Text("Football"),
                              backgroundColor: Colors.green,
                            ),
                            const Chip(
                              label: Text("Movies/Cinema"),
                              backgroundColor: Colors.cyan,
                            ),
                            const Chip(
                              label: Text("Parties"),
                              backgroundColor: Colors.pink,
                            ),
                            const Chip(
                              label: Text("Study Together"),
                              backgroundColor: Colors.purple,
                            ),
                          ],
                        ),
                      ]),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                const Text(
                  "Stats",
                  style: TextStyle(fontSize: 24.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Notes: ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "25",
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Column(
                      children: [
                        const Text(
                          "Friends: ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "26",
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Column(
                      children: [
                        const Text(
                          "Likes: ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "157",
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "All Sticky notes",
              style: TextStyle(fontSize: 24.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (BuildContext context, int index) {
                  Text note = notes[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.sticky_note_2,
                      color: Colors.amber,
                    ),
                    title: note,
                  );
                },
              ),
            ),
          ]),
        );
      }),
    );
  }
}
