import 'package:http/http.dart' as http;
import "dart:convert";

class Authenticate {
  final String email;
  final String password;
  static String accessToken = "";
  Authenticate({required this.email, required this.password});
  Future send() async {
    http.Response response = await http.post(
      Uri.parse("https://pos-app.com/public/oauth/token"),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(
        {
          "grant_type": "password",
          "client_id": 2,
          "client_secret": "xGt1pB6wCVxpE3xoSyHQROCP8QsHGsh713sPnpg9",
          "username": email,
          "password": password
        },
      ),
    );
    if (response.statusCode == 200) {
      accessToken = jsonDecode(response.body)['access_token'];
      return true;
    }
    return false;
  }
}
