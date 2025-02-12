import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, double>> fetchExchangeRates() async {
  final apiKey = dotenv.env['API_KEY'];
  final url = 'https://v6.exchangerate-api.com/v6/$apiKey/latest/USD';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    data['conversion_rates'].forEach((currency, rate) {
      print('$currency: $rate');
    });
    return {
      "USD": (data['conversion_rates']['USD'] as num).toDouble(),
      "VND": (data['conversion_rates']['VND'] as num).toDouble(),
      "EUR": (data['conversion_rates']['EUR'] as num).toDouble(),
      "GBP": (data['conversion_rates']['GBP'] as num).toDouble(),
    };
  } else {
    throw Exception('Failed to load exchange rates');
  }
}
