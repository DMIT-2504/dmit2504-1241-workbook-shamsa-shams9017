import 'dart:convert';
import 'package:http/http.dart' as http;

class StoreService {
  Future<dynamic> fetchProducts() async {
    try {
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products?limit=10'));

      if (response.statusCode == 200) {
        return _deserialize(response.body);
      } else {
        throw Exception('Failed to load products. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching products: $error');
    }
  }

  List<dynamic> _deserialize(String responseBody) {
    try {
      return json.decode(responseBody);
    } catch (error) {
      throw Exception('Failed to parse response: $error');
    }
  }
}
