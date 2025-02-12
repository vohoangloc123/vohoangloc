import 'package:currencyconverter/screens/analysts_creen.dart';
import 'package:currencyconverter/services/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? _fromCurrency = 'USD';
  String? _toCurrency = 'VND';
  double? _convertedAmount;
  bool _isLoading = false;

  final List<String> currencies = ['USD', 'VND', 'EUR', 'GBP'];
  final Map<String, String> currencyFlags = {
    'USD': 'assets/flags/us.png',
    'VND': 'assets/flags/vn.png',
    'EUR': 'assets/flags/eu.png',
    'GBP': 'assets/flags/gb.png',
  };

  void _handleConvert() async {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    try {
      String sanitizedInput =
          _amountController.text.replaceAll(RegExp(r'[,.]'), '');
      amount = double.parse(sanitizedInput);

      if (_fromCurrency == 'VND' || _toCurrency == 'VND') {
        if (amount != amount.floorToDouble()) {
          showErrorSnackbar(context, 'VND must be a whole number.');
          return;
        }
      }

      if (amount <= 0) {
        showErrorSnackbar(context, 'Amount must be greater than 0.');
        return;
      }

      if (_fromCurrency == _toCurrency) {
        showErrorSnackbar(context, 'From and To currencies must be different.');
        return;
      }
    } catch (_) {
      showErrorSnackbar(
          context, 'Invalid amount. Please enter a valid number.');
      return;
    }

    setState(() {
      _isLoading = true;
      _convertedAmount = null;
    });

    final result = await convertCurrency(
      amount: amount,
      fromCurrency: _fromCurrency!,
      toCurrency: _toCurrency!,
      context: context,
    );

    setState(() {
      _isLoading = false;
      _convertedAmount = result;
    });
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnalystScreen()),
              );
            },
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8), // Khoảng cách giữa icon và text
                Text(
                  'Exchange Rate Analyst',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 8),
                Icon(Icons.analytics,
                    color: Theme.of(context).colorScheme.primary),
              ],
            ),
            tooltip: 'Go to Analyst Screen',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Currency Converter',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    items: currencies.map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: Row(
                          children: [
                            Image.asset(
                              currencyFlags[currency]!,
                              width: 24,
                              height: 16,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8.0),
                            Text(currency),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _fromCurrency = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'From Currency',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: _swapCurrencies,
                  tooltip: 'Swap currencies',
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toCurrency,
                    items: currencies.map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: Row(
                          children: [
                            Image.asset(
                              currencyFlags[currency]!,
                              width: 24,
                              height: 16,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8.0),
                            Text(currency),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _toCurrency = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'To Currency',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _handleConvert,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Bo góc nhẹ 8px
                ),
              ),
              child: Text(
                'Convert',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_isLoading)
              SpinKitWaveSpinner(
                color: Theme.of(context).colorScheme.primary,
                size: 100.0,
              )
            else if (_convertedAmount != null)
              Text(
                'Converted Amount: ${_convertedAmount!.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            else
              Text(
                'Please enter an amount and select currencies to convert.',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
