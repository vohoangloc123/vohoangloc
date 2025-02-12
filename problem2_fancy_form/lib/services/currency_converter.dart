import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<double?> convertCurrency({
  required double amount,
  required String fromCurrency,
  required String toCurrency,
  required BuildContext context,
}) async {
  final apiKey = dotenv.env['API_KEY'];
  final url = Uri.parse(
      'https://v6.exchangerate-api.com/v6/$apiKey/latest/$fromCurrency?symbols=$toCurrency');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['conversion_rates'] != null &&
          data['conversion_rates'][toCurrency] != null) {
        double conversionRate = data['conversion_rates'][toCurrency];
        return amount * conversionRate;
      } else {
        throw 'Conversion rates or $toCurrency not found';
      }
    } else {
      throw 'Failed to fetch exchange rates';
    }
  } catch (e) {
    if (e is http.ClientException) {
      showErrorSnackbar(
          context, 'Network error occurred. Please try again later.');
    } else {
      showErrorSnackbar(context, 'Error: $e');
    }
    return null;
  }
}

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}
