class UserModel {
  final String username;
  final String email;
  final String password;
  final String userId;
  String profileDescription;
  List<int>? selectedTags;
  List<String>? friends;

  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.profileDescription,
      required this.selectedTags,
      required this.friends,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'profileDescription': profileDescription,
      'selectedTags': selectedTags,
      'friends': friends,
      'userId': userId
    };
  }
}
