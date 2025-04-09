import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://your_internal_api_address';

  Future getParkInfo() async {
    final response = await http.get(Uri.parse('$baseUrl/park_info'));
    return jsonDecode(response.body);
  }

  Future findCar(String plateNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/find_car?plate=$plateNumber'));
    return jsonDecode(response.body);
  }

  Future makeReservation(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reserve'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }
}