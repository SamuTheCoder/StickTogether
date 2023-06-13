import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String note;
  GeoPoint location;
  DateTime expireTime;
  final String userId;
  NoteModel(
      {required this.note,
      required this.location,
      required this.expireTime,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'expire_time': expireTime,
      'user_id': userId,
      'location': location
    };
  }
}
