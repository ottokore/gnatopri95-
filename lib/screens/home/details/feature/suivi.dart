import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class SuiviTransactions extends StatefulWidget {
  const SuiviTransactions({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuiviTransactionsState createState() => _SuiviTransactionsState();
}

class _SuiviTransactionsState extends State<SuiviTransactions> with TickerProviderStateMixin {
  int _selectedMonth = 0;
  final List<double> _monthlyExpenses = [12500.0, 8900.0, 34200.0, 1800.0, 15000.0, 9950.0, 20000.0, 30000.0, 45000.0];
  final List<List<FlSpot>> _monthlySpots = [
    [const FlSpot(0, 35000.0), const FlSpot(1, 32000.0), const FlSpot(2, 20000.0), const FlSpot(3, 27000.0)], // Mars
    [const FlSpot(0, 42000.0), const FlSpot(1, 39000.0), const FlSpot(2, 50000.0), const FlSpot(3, 45000.0)], // Juin
    [const FlSpot(0, 30000.0), const FlSpot(1, 42000.0), const FlSpot(2, 18000.0), const FlSpot(3, 25000.0)], // Septembre
    [const FlSpot(0, 18000.0), const FlSpot(1, 25000.0), const FlSpot(2, 30000.0), const FlSpot(3, 22000.0)], // Décembre
    [const FlSpot(0, 40000.0), const FlSpot(1, 35000.0), const FlSpot(2, 28000.0), const FlSpot(3, 32000.0)], // Mars
    [const FlSpot(0, 45000.0), const FlSpot(1, 38000.0), const FlSpot(2, 32000.0), const FlSpot(3, 30000.0)], // Juin
  ];
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('fr');

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColor,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Image.asset(
                'assets/images/dassi_logo.png',
                height: 26,
              ),
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(
                  top: h * 0.04,
                ),
              ),
              Text(
                "Suivi de transactions",
                style: TextStyle(
                  fontSize: w * 0.053,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Lévolution de vos activités",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: descColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h * 0.04),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  final month = ['Janvier', 'Juin', 'Septembre', 'Décembre', 'Mars', 'Juin'][index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedMonth = index;
                          _animationController?.forward(from: 0);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedMonth == index ? primaryColor : Colors.white,
                        foregroundColor: _selectedMonth == index ? Colors.white : primaryColor,
                      ),
                      child: Text(month),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vos dépenses',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 6),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${numberFormat.format(_monthlyExpenses[_selectedMonth])} ',
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
                                  ),
                                  const TextSpan(
                                    text: 'FCFA',
                                    style: TextStyle(fontSize: 16, color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Logique pour afficher les détails
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor, // Utilisation de la couleur secondaryColor
                            foregroundColor: Colors.white, // Police en blanc
                          ),
                          child: const Text('Détails'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedBuilder(
                      animation: _animationController!,
                      builder: (context, child) {
                        return AspectRatio(
                          aspectRatio: 1.6,
                          child: LineChart(
                            LineChartData(
                              lineTouchData: const LineTouchData(enabled: false),
                              gridData: FlGridData(
                                show: true,
                                drawHorizontalLine: false,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Colors.grey.withOpacity(0.3),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                              ),
                              minY: 0,
                              maxY: 50000,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: _monthlySpots[_selectedMonth],
                                  isCurved: true,
                                  color: secondaryColor,
                                  barWidth: 5,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: const Color.fromARGB(255, 3, 106, 223).withOpacity(0.3),
                                  ),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(value.toStringAsFixed(1)),
                                      );
                                    },
                                    reservedSize: 32,
                                  ),
                                ),
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}