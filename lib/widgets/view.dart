import 'package:flutter/material.dart';

class ViewAllTransactions extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  final String Function(double) formatRupiah;
  final String Function(DateTime) formatDate;

  const ViewAllTransactions({
    Key? key,
    required this.transactions,
    required this.formatRupiah,
    required this.formatDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
        centerTitle: true,
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text(
                'No transactions available.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions.reversed.toList()[index];

                String category = transaction['category'] ?? 'Unknown Category';
                double amount = transaction['amount'] ?? 0;
                String formattedAmount = formatRupiah(amount);
                DateTime date = transaction['date'] ?? DateTime.now();
                String formattedDate = formatDate(date);

                // Ikon berdasarkan kategori
                IconData icon;
                Color iconColor;

                switch (category) {
                  case 'Food':
                    icon = Icons.fastfood;
                    iconColor = Colors.orange;
                    break;
                  case 'Shopping':
                    icon = Icons.shopping_bag;
                    iconColor = Colors.purple;
                    break;
                  case 'Health':
                    icon = Icons.health_and_safety;
                    iconColor = Colors.green;
                    break;
                  case 'Travel':
                    icon = Icons.airplanemode_active;
                    iconColor = Colors.blue;
                    break;
                  case 'Transport':
                    icon = Icons.directions_car;
                    iconColor = Colors.blueGrey;
                    break;
                  case 'Bills':
                    icon = Icons.receipt;
                    iconColor = Colors.lightBlue;
                    break;
                  case 'Salary':
                    icon = Icons.payments;
                    iconColor = Colors.amber;
                    break;
                  case 'Entertainment':
                    icon = Icons.movie;
                    iconColor = Colors.teal;
                    break;
                  default:
                    icon = Icons.more_horiz;
                    iconColor = Colors.grey;
                    break;
                }

                IconData arrowIcon = transaction['type'] == 'Income'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward;

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      backgroundColor: iconColor,
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      category,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              arrowIcon,
                              color: transaction['type'] == 'Income'
                                  ? Colors.green
                                  : Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formattedAmount,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
