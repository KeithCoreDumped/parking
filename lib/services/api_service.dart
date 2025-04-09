import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000'; // 或你的局域网服务器IP

  Future<Map<String, dynamic>> getParkInfo() async {
    final response = await http.get(Uri.parse('$baseUrl/park_info'));
    print(response);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> findCar(String plate) async {
    final response = await http.get(Uri.parse('$baseUrl/find_car?plate=$plate'));
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getViolation(String plate) async {
    final response = await http.get(Uri.parse('$baseUrl/violation?plate=$plate'));
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> makeReservation(String plate, String date, String time) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reserve'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "plate": plate,
        "date": date,
        "time": time
      }),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> pay(String plate, int amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pay'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "plate": plate,
        "amount": amount
      }),
    );
    return jsonDecode(response.body);
  }
}
