import 'dart:convert';

import 'package:stick_together_app/components/router.dart';
import 'package:http/http.dart' as http;

class SiginService {
  signUp(String email, String password) async {
    //Uri uri = Uri.https(Router())
    http.Response response = await http.post(
      Uri.parse(Router.url),
      body: json.encode(
        {
          "email": email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(response.body);
  }
}
