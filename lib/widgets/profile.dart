import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar dengan MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Warna oranye yang digunakan di HomeScreen
    final Color primaryColor = const Color(0xFFFF6F00); // Warna oranye

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Aksi untuk edit profil
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Menggunakan persentase lebar layar
          vertical: screenHeight * 0.02, // Menggunakan persentase tinggi layar
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil user
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: screenWidth *
                        0.15, // Sesuaikan radius avatar berdasarkan lebar layar
                    backgroundColor: primaryColor, // Warna oranye
                    child: const Icon(Icons.person,
                        color: Colors.white, size: 50), // Ikon profil
                  ),
                  SizedBox(
                      height:
                          screenHeight * 0.02), // Jarak dinamis antara elemen
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: screenHeight * 0.04), // Jarak dinamis antara elemen

            // List opsi profile
            buildProfileOption(
              context,
              icon: Icons.account_circle,
              label: 'My account',
              onTap: () {
                // Aksi untuk "My account"
              },
              iconColor: primaryColor, // Warna oranye untuk ikon
            ),
            buildProfileOption(
              context,
              icon: Icons.refresh,
              label: 'Reset',
              onTap: () {
                // Aksi untuk "Reset"
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Reset'),
                      content: const Text('Are you sure you want to reset?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Implementasikan logika reset di sini
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
              iconColor: primaryColor, // Warna oranye untuk ikon
            ),
            buildProfileOption(
              context,
              icon: Icons.help_outline,
              label: 'Help and Support',
              onTap: () {
                // Aksi untuk "Help and Support"
              },
              iconColor: primaryColor, // Warna oranye untuk ikon
            ),
            buildProfileOption(
              context,
              icon: Icons.exit_to_app,
              label: 'Exit Application',
              onTap: () {
                // Aksi untuk keluar dari aplikasi
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Exit App'),
                      content:
                          const Text('Are you sure you want to exit the app?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              // Keluar dari aplikasi
                              Navigator.of(context).maybePop();
                            });
                          },
                          child: const Text('Exit'),
                        ),
                      ],
                    );
                  },
                );
              },
              iconColor: primaryColor, // Warna oranye untuk ikon
            ),

            SizedBox(
                height: screenHeight * 0.05), // Jarak dinamis antara elemen

            // Tombol Logout
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logika log out
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth *
                        0.2, // Tombol lebih responsif berdasarkan lebar layar
                    vertical: screenHeight *
                        0.02, // Ukuran tombol berdasarkan tinggi layar
                  ),
                  backgroundColor:
                      primaryColor, // Warna oranye untuk tombol logout
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun ListTile profil
  Widget buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color iconColor, // Tambahkan warna ikon sebagai parameter
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ListTile(
      leading: Container(
        height: screenWidth * 0.1, // Ukuran icon lebih responsif
        width: screenWidth * 0.1,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1), // Gunakan warna sesuai tema
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor), // Warna ikon mengikuti warna utama
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }
}
