class UserModel {
  final String username;
  final String email;
  final String password;
  String profileDescription;
  List<int>? selectedTags;

  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.profileDescription,
      required this.selectedTags});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'profileDescription': profileDescription,
      'selectedTags': selectedTags
    };
  }
}
