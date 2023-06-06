import 'package:flutter/material.dart';
import 'package:stick_together_app/components/textfield.dart';

class NewStickyPage extends StatefulWidget {
  const NewStickyPage({super.key});

  @override
  State<NewStickyPage> createState() => _NewStickyPageState();
}

class _NewStickyPageState extends State<NewStickyPage> {
  final _descriptionController = TextEditingController();

  final timeSpans = [
    "15 minutes",
    "30 minutes",
    "1 hour",
    "2 hours",
    "4 hours"
  ];

  String? _currentTimeSpan = "15 minutes";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [
              Text(
                "Sticky Note's TimeSpan:  ",
                style: TextStyle(fontSize: 15),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentTimeSpan,
                    style: TextStyle(fontSize: 15),
                    items: timeSpans
                        .map<DropdownMenuItem<String>>(buildMenuItem)
                        .toList(),
                    onChanged: (value) => setState(() {
                      _currentTimeSpan = value;
                    }),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Description:",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
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
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber)),
                onPressed: () {},
                child: const Text("Create Sticky Note")),
          )
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String time) =>
      DropdownMenuItem(value: time, child: Text(time));
}
