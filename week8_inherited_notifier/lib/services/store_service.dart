import 'dart:convert';
import 'package:http/http.dart' as http;

class StoreService {
  Future<List<Map<String, dynamic>>> fetchProducts() async {
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

  List<Map<String, dynamic>> _deserialize(String responseBody) {
    try {
      List<dynamic> decodedJson = json.decode(responseBody);

      List<Map<String, dynamic>> productList = [];

      for (var item in decodedJson) {
        if (item is Map<String, dynamic>) {
          productList.add(item);
        } else {
          throw Exception('Unexpected item type in response: ${item.runtimeType}');
        }
      }

      return productList;

    } catch (error) {
      throw Exception('Failed to parse response: $error');
    }
  }
}
