import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:statemanagement/models/dummy_model.dart';

class DummyServices {
  static const String baseUrl = 'https://dummyjson.com/products';

  static Future<List<DummyProduct>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];
      return products.map((e) => DummyProduct.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<DummyProduct> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DummyProduct.fromJson(data);
    } else {
      throw Exception('Failed to load product');
    }
  }
}
