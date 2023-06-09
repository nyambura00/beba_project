import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8000'; // Replace with your Laravel API base URL

  Future<String> getToken() async {
    final response = await http.get(Uri.parse('$baseUrl/token'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<String> initiateStkPush() async {
    final token = await getToken();
    final url = '$baseUrl/initiateStkPush';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['message'];
    } else {
      throw Exception('Failed to initiate STK push');
    }
  }

  Future<void> stkCallback() async {
    final url = '$baseUrl/stkCallback';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to handle callback response');
    }
  }

  Future<http.Response> stkQuery() async {
    final token = await getToken();
    final url = '$baseUrl/stkQuery';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response;
  }
}
