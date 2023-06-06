class Position {
  String userName;
  String email;
  String password;
  String phone;
  //Bob photo;
  Position(
      {required this.userName,
      required this.email,
      required this.password,
      this.phone = 'null'});
}
