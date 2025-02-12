import 'package:currencyconverter/models/chart_data.dart';
import 'package:currencyconverter/services/fetch_exchange_rates.dart';
import 'package:currencyconverter/widgets/chart_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalystScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exchange Rates Chart',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context)
              .colorScheme
              .primary, // Change the color of the back arrow
        ),
      ),
      body: FutureBuilder<Map<String, double>>(
        future: fetchExchangeRates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitWaveSpinner(
                color: Theme.of(context).colorScheme.primary,
                size: 100.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Prepare data for the chart
            List<ChartData> chartData = snapshot.data!.entries.map((entry) {
              return ChartData(entry.key, entry.value);
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Card(
                  elevation: 4, // You can adjust the elevation as needed
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // Rounded corners (optional)
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16.0), // Padding inside the Card
                    child: CustomPaint(
                      size: const Size(double.infinity,
                          400), // Increase height for better display
                      painter: ChartPainter(chartData),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
