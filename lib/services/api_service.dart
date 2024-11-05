import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car.dart';
import '../models/category.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Car>> getCars() async {
    final response = await http.get(Uri.parse('$baseUrl/cars'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((car) => Car.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load cars');
    }
  }

  Future<Car> createCar(Car car) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cars'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(car.toJson()),
    );
    if (response.statusCode == 201) {
      return Car.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create car');
    }
  }

  Future<Car> updateCar(Car car) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cars/${car.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(car.toJson()),
    );
    if (response.statusCode == 200) {
      return Car.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update car');
    }
  }

  Future<void> deleteCar(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/cars/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete car');
    }
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
