class UserModel {
  final String username;
  final String email;
  final String password;
  String profileDescription;

  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.profileDescription});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'profileDescription': profileDescription
    };
  }
}
