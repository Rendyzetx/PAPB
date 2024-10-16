import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function(String, String, String, DateTime, double) onSave;

  const AddTransaction({required this.onSave, Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String? selectedType;
  String? selectedCategory;
  DateTime selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController();
  final formatCurrency = NumberFormat.currency(
      locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0); // Pemformat Rupiah

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // Fungsi validasi input amount
  bool _validateAmount() {
    if (amountController.text.isEmpty) {
      return false; // Jika amount kosong
    }
    try {
      _getRawAmount(); // Pastikan bisa diubah jadi double
      return true;
    } catch (e) {
      return false; // Jika tidak bisa diubah menjadi double, invalid
    }
  }

  // Fungsi untuk mengambil nilai asli tanpa titik dan simbol Rp
  double _getRawAmount() {
    String value = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    return double.parse(value);
  }

  // Fungsi untuk memformat input menjadi format Rupiah dengan titik ribuan
  void _formatAmount() {
    String value = amountController.text
        .replaceAll(RegExp(r'[^0-9]'), ''); // Hapus semua karakter non-numerik
    if (value.isNotEmpty) {
      double amount = double.parse(value);
      setState(() {
        amountController.text = formatCurrency
            .format(amount)
            .replaceAll(',00', ''); // Format tanpa desimal
        amountController.selection = TextSelection.fromPosition(
          TextPosition(offset: amountController.text.length),
        ); // Jaga posisi kursor di akhir
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar dengan MediaQuery
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Gunakan SingleChildScrollView agar form dapat di-scroll pada layar kecil
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input jumlah uang dengan format Rupiah dan titik ribuan
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: const Icon(
                      Icons.attach_money), // Simbol dolar di sebelah kiri
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorText: _validateAmount() || amountController.text.isEmpty
                      ? null
                      : 'Please enter a valid amount',
                ),
                onChanged: (value) {
                  _formatAmount(); // Panggil fungsi format saat input berubah
                },
              ),
              SizedBox(height: screenHeight * 0.03), // Jarak dinamis

              // Dropdown untuk Type (Income / Expense)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Type',
                  prefixIcon: const Icon(Icons.account_balance_wallet),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Income',
                    child: Text('Income'),
                  ),
                  DropdownMenuItem(
                    value: 'Expense',
                    child: Text('Expense'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
                value: selectedType, // Menjaga pilihan yang sudah ada
              ),
              SizedBox(height: screenHeight * 0.03), // Jarak dinamis

              // Pilihan kategori
              Text(
                'Category',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: screenHeight * 0.015), // Jarak dinamis

              // Tampilan kategori dalam grid menggunakan GridView
              SizedBox(
                height: screenHeight * 0.35, // Batas tinggi untuk GridView
                child: GridView.count(
                  crossAxisCount:
                      4, // Ubah jumlah kolom menjadi 4 (atau sesuai kebutuhan)
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildCategoryTile(
                        'Transport', Icons.directions_car, Colors.blue),
                    _buildCategoryTile(
                        'Health', Icons.health_and_safety, Colors.red),
                    _buildCategoryTile(
                        'Shopping', Icons.shopping_bag, Colors.purple),
                    _buildCategoryTile('Bills', Icons.receipt, Colors.orange),
                    _buildCategoryTile(
                        'Entertainment', Icons.movie, Colors.green),
                    _buildCategoryTile(
                        'Travel', Icons.airplanemode_active, Colors.teal),
                    _buildCategoryTile('Salary', Icons.payments, Colors.amber),
                    _buildCategoryTile('Food', Icons.fastfood, Colors.orange),
                    _buildCategoryTile('Other', Icons.more_horiz, Colors.grey),
                  ],
                ),
              ),

              // Pilihan tanggal dengan label "Date"
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Agar label "Date" rata kiri
                children: [
                  const Text(
                    'Date', // Teks label Date
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                      height:
                          screenHeight * 0.01), // Jarak antara teks dan tanggal
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                    onTap: () => _selectDate(context),
                  ),
                ],
              ),

              // Tombol Save
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ), // Ukuran tombol lebih responsif
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (selectedType != null &&
                        selectedCategory != null &&
                        _validateAmount()) {
                      widget.onSave(
                        selectedType!,
                        selectedCategory!,
                        amountController.text,
                        selectedDate,
                        _getRawAmount(), // Ambil nilai tanpa format
                      );
                      Navigator.pop(context);
                    } else {
                      // Tampilkan error jika ada input yang kosong atau tidak valid
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please fill all fields correctly.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk kategori dengan ikon dan nama
  // Widget untuk kategori dengan ikon dan nama
  Widget _buildCategoryTile(String category, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedCategory == category ? color : color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 25), // Ikon kategori
            const SizedBox(height: 8),
            Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12, // Ukuran font diperkecil
              ),
              overflow: TextOverflow
                  .ellipsis, // Jika teks terlalu panjang, tambahkan titik-titik (...)
              maxLines: 1, // Batasi teks menjadi 1 baris
              textAlign: TextAlign.center, // Teks di tengah
            ),
          ],
        ),
      ),
    );
  }
}
