// spoonacular_api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';

class SpoonacularApi {
  static const apiKey = 'ba4c49b99e0a497bb6a11a683a07ac44';


Future<List<Product>> fetchProducts() async {
  try {
    
    final response = await http.get(Uri.parse('https://api.spoonacular.com/food/products/random?apiKey=ba4c49b99e0a497bb6a11a683a07ac44&number=10'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product(id: json['id'], name: json['title'], price: (json['price'] as num).toDouble())).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Failed to fetch products: $error');
  }
}
}
