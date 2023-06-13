import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stick_together_app/map_page.dart';
import 'package:stick_together_app/new_sticky_note.dart';
import 'package:stick_together_app/profile.dart';
import 'package:stick_together_app/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = [MapPage(), NewStickyPage(), ProfilePage(), SearchPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("StickTogether",
            style: TextStyle(
              color: Colors.amber,
            )),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2), label: "New Sticky Note"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "People"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
