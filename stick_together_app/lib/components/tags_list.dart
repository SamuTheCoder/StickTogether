import 'package:flutter/material.dart';

class Tag {
  final String name;
  final Color color;

  Tag({required this.name, required this.color});
}

List<Tag> tagsList = [
  Tag(name: "Movies", color: Colors.black),
  Tag(name: "Art/Crafting", color: Colors.orangeAccent),
  Tag(name: "Music", color: Colors.purple),
  Tag(name: "Sports", color: Colors.green),
  Tag(name: "Travel", color: Colors.teal),
  Tag(name: "Gaming", color: Colors.red),
  Tag(name: "Parties", color: Colors.pink),
  Tag(name: "Drinking", color: Colors.deepOrange),
  Tag(name: "Studying", color: Colors.blue),
  Tag(name: "Wilderness", color: Colors.lightGreen),
  Tag(name: "Adventures", color: Colors.yellow),
];
