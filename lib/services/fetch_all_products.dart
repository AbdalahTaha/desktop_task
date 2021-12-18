import 'dart:convert';
import 'package:http/http.dart' as http;
import './authentication.dart';

class fetchAllProducts {
  var _items = [];
  getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://pos-app.com/public/api/products'),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${Authenticate.accessToken}'
        },
      );
      _items = jsonDecode(response.body);
      return _items;
    } catch (e) {
      throw e;
    }
  }
}
