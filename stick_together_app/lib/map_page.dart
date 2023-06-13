import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stick_together_app/models/NoteModel.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  Future<void> loadMarkers() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final notes = await getNotesFromCurrentUser(userId);

      final updateMarkers = await Future.wait(notes.map((note) async {
        final username = await getUserName(note.userId);

        return Marker(
            point: LatLng(note.location.latitude, note.location.longitude),
            builder: (context) => GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(username,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.amber)),
                                Text(note.note,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                                SizedBox(height: 8),
                              ],
                            ),
                          )));
                },
                child: Icon(
                  Icons.pin_drop,
                  color: Colors.red,
                  size: 35,
                )));
      }).toList());
      setState(() {
        markers = updateMarkers;
        debugPrint("${markers.length}");
      });
    }
  }

  Future<List<NoteModel>> getNotesFromCurrentUser(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('note')
        .where('user_id', isEqualTo: userId)
        .get();

    final notes = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return NoteModel(
          note: data['note'],
          location: data['location'],
          expireTime: (data['expire_time'] as Timestamp).toDate(),
          userId: data['user_id']);
    }).toList();

    return notes;
  }

  Future<String> getUserName(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final data = doc.data();
    return data!['username'];
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                  center: LatLng(40.6412, -8.65362),
                  zoom: 8.0,
                  minZoom: 3.0,
                  maxZoom: 18.0),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(
                  markers: markers,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
