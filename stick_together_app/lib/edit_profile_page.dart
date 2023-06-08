import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _descriptionController = TextEditingController();
  final _userController = TextEditingController();

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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 8,
            ),
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
      ),
    );
  }
}
