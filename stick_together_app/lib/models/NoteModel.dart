class NoteModel {
  String note;
  int expireTime;
  final int userId;

  NoteModel(
      {required this.note, required this.expireTime, required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'expire_time': expireTime,
      'user_id': userId,
    };
  }
}
