import 'package:currencyconverter/screens/currency_converter_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 79, 87, 176),
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color.fromARGB(255, 79, 87, 176),
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: const Color.fromARGB(255, 79, 87, 176),
          surface: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
          tertiary: const Color.fromARGB(255, 79, 87, 176),
        ),
      ),
      home: const CurrencyConverterScreen(), // Màn hình CurrencyConverterScreen
    );
  }
}
