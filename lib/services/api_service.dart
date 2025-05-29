import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = Uri.base.replace(
    scheme: 'http',
    port: 5000,
  ).toString().replaceAll(RegExp(r'/+$'), ''); // 或你的局域网服务器IP
  
  Future<Map<String, dynamic>> getParkInfo() async {
    final response = await http.get(Uri.parse('$baseUrl/park_info'));
    print(response);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> findCar(String plate) async {
    return { "position": "A2", "plate": plate, "park": "sdf" };
    // final response = await http.get(
    //   Uri.parse('$baseUrl/find_car?plate=$plate'),
    // );
    // return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getViolation(String plate) async {
    final response = await http.get(
      Uri.parse('$baseUrl/violation?plate=$plate'),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> query(String plate) async {
    final response = await http.get(Uri.parse('$baseUrl/query?plate=$plate'));
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> makeReservation(
    String plate,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reserve'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"plate": plate}),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> pay(String plate) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pay'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"plate": plate}),
    );
    return jsonDecode(response.body);
  }
}
