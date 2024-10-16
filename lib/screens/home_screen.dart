import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_transactions.dart';
import 'statistic_screen.dart';
import 'package:spend_diary/widgets/view.dart';
import 'package:spend_diary/widgets/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index untuk melacak halaman yang sedang aktif

  double income = 0;
  double expense = 0;
  List<Map<String, dynamic>> transactions = [];

  // Hitung total balance
  double get totalBalance => income + expense;

  // Format ke Rupiah
  String formatRupiah(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatCurrency.format(amount);
  }

  // Fungsi untuk menambah transaksi
  void addTransaction(String type, String category, String amountString,
      DateTime date, double amount) {
    setState(() {
      if (type == 'Income') {
        income += amount;
        transactions.add({
          'type': 'Income',
          'category': category,
          'amount': amount,
          'date': date,
        });
      } else if (type == 'Expense') {
        expense += amount; // Expense tetap positif di data
        transactions.add({
          'type': 'Expense',
          'category': category,
          'amount': -amount, // Masukkan sebagai nilai negatif untuk tampil
          'date': date,
        });
      }
    });
  }

  // Fungsi untuk format tanggal dinamis
  String formatDate(DateTime date) {
    final today = DateTime.now();
    final difference = today.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  // Fungsi untuk mengubah halaman saat tombol bottom navigation bar ditekan
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            // Halaman HomeScreen
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Welcome!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: IconButton(
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Navigasi ke halaman profile saat avatar ditekan
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Total Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6F00),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Spend',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          formatRupiah(totalBalance),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: Colors.white54,
                          thickness: 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Income',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatRupiah(income),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Expenses',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatRupiah(expense),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Transactions Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Transactions',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewAllTransactions(
                                transactions: transactions,
                                formatRupiah: formatRupiah,
                                formatDate: formatDate,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 152, 153, 155),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Transaction List
                  Expanded(
                    child: transactions.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.hourglass_empty,
                                  size: 80,
                                  color: Colors.black54,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Belum ada transaksi. Tambahkan transaksi baru!',
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction =
                                  transactions.reversed.toList()[index];

                              String category = transaction['category'] ??
                                  'Kategori Tidak Diketahui';
                              double amount = transaction['amount'] ?? 0;
                              String formattedAmount = formatRupiah(amount);
                              DateTime date =
                                  transaction['date'] ?? DateTime.now();
                              String formattedDate = formatDate(date);

                              // Menentukan ikon berdasarkan kategori
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
                                  iconColor =
                                      const Color.fromARGB(255, 74, 207, 13);
                                  break;
                                default:
                                  icon = Icons.more_horiz;
                                  iconColor = Colors.grey;
                                  break;
                              }

                              IconData arrowIcon =
                                  transaction['type'] == 'Income'
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward;

                              return buildTransactionItem(
                                icon,
                                arrowIcon,
                                category,
                                formattedAmount,
                                formattedDate,
                                transaction['type'] == 'Income'
                                    ? Colors.green
                                    : Colors.red,
                                iconColor,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),

            // Halaman StatisticScreen
            StatisticScreen(
              totalIncome: income,
              totalExpense: expense,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransaction(
                onSave: addTransaction,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFFF6F00),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () => _onItemTapped(0), // Tampilkan HomeScreen
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.bar_chart),
                    onPressed: () =>
                        _onItemTapped(1), // Tampilkan StatisticScreen
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTransactionItem(
      IconData icon,
      IconData arrowIcon,
      String category,
      String amount,
      String time,
      Color color,
      Color iconColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                  color: color,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  amount,
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
              time,
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
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
