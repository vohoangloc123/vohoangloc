import 'package:currencyconverter/models/chart_data.dart';
import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter {
  final List<ChartData> chartData;
  final List<Color> colors = [
    const Color.fromARGB(255, 182, 166, 233),
    const Color.fromARGB(255, 67, 148, 229),
    const Color.fromARGB(255, 135, 187, 98),
    const Color.fromARGB(255, 245, 146, 27),
  ];

  String currentDate = DateTime.now().toString().split(' ')[0];
  ChartPainter(this.chartData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final textStyle = TextStyle(color: Colors.black, fontSize: 14);
    double barWidth =
        size.width / (chartData.length * 2); // Increased space between bars

    // Maximum bar height for scaling
    double maxBarHeight = size.height - 80;
    // Minimum bar height to ensure that even small values are visible
    double minBarHeight = 50;

    // Draw bars
    for (int i = 0; i < chartData.length; i++) {
      paint.color = colors[i % colors.length];

      // Calculate the height of the bar with a minimum height for all bars
      double barHeight = chartData[i].rate * 10; // Scaling factor for all rates
      barHeight = barHeight < minBarHeight ? minBarHeight : barHeight;

      // Make sure the height doesn't exceed the max height
      if (barHeight > maxBarHeight) {
        barHeight = maxBarHeight;
      }

      // Draw bar
      canvas.drawRect(
        Rect.fromLTWH(i * barWidth * 2 + 40, size.height - barHeight - 40,
            barWidth, barHeight),
        paint,
      );

      // Draw currency name below the bar
      TextSpan currencyText = TextSpan(
        text: chartData[i].currency,
        style: textStyle,
      );
      TextPainter currencyPainter = TextPainter(
        text: currencyText,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      currencyPainter.layout();
      currencyPainter.paint(
        canvas,
        Offset(i * barWidth * 2 + 40 + (barWidth - currencyPainter.width) / 2,
            size.height - 30),
      );

      // Draw exchange rate above the bar
      TextSpan rateText = TextSpan(
        text: chartData[i].rate.toStringAsFixed(2),
        style: textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
      );
      TextPainter ratePainter = TextPainter(
        text: rateText,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      ratePainter.layout();
      ratePainter.paint(
        canvas,
        Offset(i * barWidth * 2 + 40 + (barWidth - ratePainter.width) / 2,
            size.height - barHeight - 30),
      );
    }

    // Draw X-axis
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    canvas.drawLine(Offset(0, size.height - 40),
        Offset(size.width, size.height - 40), paint); // X-axis line

    TextSpan titleText = TextSpan(
      text: 'Exchange Rates Chart $currentDate',
      style: textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
    );
    TextPainter titlePainter = TextPainter(
      text: titleText,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout();
    titlePainter.paint(
      canvas,
      Offset((size.width - titlePainter.width) / 2, size.height - 10),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
