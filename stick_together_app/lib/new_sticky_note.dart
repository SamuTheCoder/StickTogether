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
      child: Column(
        children: [
          Row(children: [
            Text("Time that the sticker will last: "),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentTimeSpan,
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
          SizedBox(height: 20),
          DefaultTextField(
            controller: _descriptionController,
            hintText: "Write your Sticky Note",
            obscureText: false,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String time) =>
      DropdownMenuItem(value: time, child: Text(time));
}
