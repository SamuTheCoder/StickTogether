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

  List<Tag> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.0),
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
            Align(
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
                  padding: EdgeInsets.only(bottom: 8),
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
            )
          ],
        ),
      ),
    );
  }

  Widget buildChips() => Chip(label: Text("bla"));
}
