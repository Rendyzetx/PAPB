import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class StatisticScreen extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;

  const StatisticScreen({
    Key? key,
    required this.totalIncome,
    required this.totalExpense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar dengan MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Padding horizontal dinamis
          vertical: screenHeight * 0.02, // Padding vertikal dinamis
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Transaction Statistics',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
                height: screenHeight *
                    0.02), // Jarak dinamis berdasarkan tinggi layar

            // Display Pie Chart for Income vs Expense
            Expanded(
              child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                    dataSource: _getChartData(),
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.amount,
                    dataLabelMapper: (ChartData data, _) =>
                        '${data.category}: ${data.percentage.toStringAsFixed(1)}%',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.02), // Jarak dinamis

            // Display Income and Expense details
            Padding(
              padding: EdgeInsets.only(
                  bottom: screenHeight *
                      0.07), // Padding bawah untuk menghindari FAB
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard(
                      'Income', totalIncome, Colors.green, screenWidth),
                  _buildStatCard(
                      'Expenses', totalExpense, Colors.red, screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ChartData> _getChartData() {
    final double total = totalIncome + totalExpense;
    final double incomePercentage = totalIncome / total * 100;
    final double expensePercentage = totalExpense / total * 100;

    return [
      ChartData('Income', totalIncome, incomePercentage, Colors.green),
      ChartData('Expense', totalExpense, expensePercentage, Colors.red),
    ];
  }

  // Menambahkan parameter screenWidth agar padding pada Card dapat disesuaikan dengan lebar layar
  Widget _buildStatCard(
      String title, double value, Color color, double screenWidth) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04, // Padding vertikal dinamis
          horizontal: screenWidth * 0.06, // Padding horizontal dinamis
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: screenWidth * 0.045, // Ukuran teks dinamis
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: screenWidth * 0.02), // Jarak dinamis
            Text(
              NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                  .format(value),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: screenWidth * 0.04, // Ukuran teks dinamis
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double amount;
  final double percentage;
  final Color color;

  ChartData(this.category, this.amount, this.percentage, this.color);
}
