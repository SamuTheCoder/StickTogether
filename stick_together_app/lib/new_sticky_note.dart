// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stick_together_app/components/textfield.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:geolocator/geolocator.dart';
import 'package:stick_together_app/models/NoteModel.dart';

import 'home_page.dart';

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
  final _formKey = GlobalKey<FormState>();
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<Position> positionStream;
  String status = 'Aguardado GPS';
  late Position positionLocation;

  Future<void> _createNote() async {
    if (_formKey.currentState!.validate()) {
      final String nota = _descriptionController.text.trim();
      late GeoPoint point;
      String temp = _currentTimeSpan as String;
      print(temp);
      String hor = "0";
      if (temp.contains("minutes")) {
        temp = temp.replaceAll(" minutes", "");
      } else {
        if (temp.contains("hours")) {
          temp = temp.replaceAll(" hours", "");
        } else if (temp.contains("hour")) {
          temp = temp.replaceAll(" hour", "");
        } else {
          temp = temp.replaceAll(" secound", "");
          temp = temp.replaceAll(" secounds", "");
        }
      }

      print("oiiiiiiii: " + temp);
      //int tp = temp as int;
      Duration expireInterval = Duration(minutes: int.parse(temp));
      print("AQUIIIIII: " + expireInterval.toString());
      final currentTime = DateTime.now();

      final expireTime = currentTime.add(expireInterval);
      print("AlUIIIIII: " + expireTime.toString());
      if (positionLocation != null) {
        point = GeoPoint(positionLocation.latitude, positionLocation.longitude);
      }

      try {
        User? user = FirebaseAuth.instance.currentUser;
        final NoteModel note = NoteModel(
            note: nota,
            location: point,
            expireTime: expireTime,
            userId: user!.uid); //coloquei 0 atualizar isso!
        //Falta receber o correntUser
        final CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('note');
        await usersCollection.doc(user!.uid).set(note.toMap());

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Stick Note Created'),
          duration: Duration(seconds: 2),
        ));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (error) {
        print(error);
        String errorMessage = "An error has occured";

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 2),
        ));
      }
    }
  }

  listenPosition() async {
    ph.PermissionStatus permission = await ph.Permission.location.request();
    if (permission.isDenied) {
      _showMessage(
          'you have not allowed the use of GPS, open the application settings and release the permission');
    } else {
      bool gpsIsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!gpsIsEnabled) {
        _showMessage('Your GPS is off, to get the location turn it on.');
      }

      setState(() {
        status = 'Obtendo a localização';
      });
      positionStream =
          Geolocator.getPositionStream().listen((Position position) async {
        //if (positionLocation == null) {
        positionLocation = position;
        setState(() {
          status = 'Localização obtida';
        });
        // }
      });
    }
  }

  _showMessage(String message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
  @override
  void initState() {
    listenPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  const Text(
                    "Sticky Note's TimeSpan:  ",
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentTimeSpan,
                        style: const TextStyle(fontSize: 15),
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
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Sticky note';
                    }
                    return null;
                  },
                  obscureText: false,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    onPressed: () {
                      _createNote();
                    },
                    child: const Text("Create Sticky Note")),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  DropdownMenuItem<String> buildMenuItem(String time) =>
      DropdownMenuItem(value: time, child: Text(time));
}
