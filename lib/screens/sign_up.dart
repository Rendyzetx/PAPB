import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isButtonPressed = false;
  bool _obscureText = true; // Untuk mengatur visibilitas password

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully'),
        ),
      );
    }
  }

  InputDecoration _buildInputDecoration(
    String labelText, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      fillColor: const Color(0xFF494A59),
      filled: true,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      hintText: labelText,
      hintStyle: const TextStyle(
        color: Colors.white54,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color(0xFF949494),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color(0xFF949494),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF252634),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.05, horizontal: screenWidth * 0.08),
          child: Form(
            key: _formKey, // Menambahkan key untuk mengontrol form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height:
                        screenHeight * 0.1), // Spasi dinamis berdasarkan layar

                Image.asset(
                  'assets/images/spend.png', // Path ke logo spend.png
                  height: screenHeight *
                      0.1, // Tinggi gambar logo berdasarkan tinggi layar
                  width: screenWidth *
                      0.2, // Lebar gambar logo berdasarkan lebar layar
                ),

                SizedBox(
                    height: screenHeight *
                        0.03), // Jarak dinamis antara logo dan teks

                // Teks Create new Account dengan font Poppins
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Create new Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(
                    height: screenHeight * 0.05), // Spasi dinamis sebelum input

                // Kolom Username dengan ikon dan teks putih
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: _buildInputDecoration(
                    'Username',
                    prefixIcon: Icon(
                      Icons.person,
                      color: const Color(0xFF949494),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: screenHeight *
                        0.02), // Jarak dinamis antara kolom input

                // Kolom Email dengan ikon dan teks putih
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: _buildInputDecoration(
                    'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: const Color(0xFF949494),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: screenHeight *
                        0.02), // Jarak dinamis antara kolom input

                // Kolom Password dengan ikon gembok dan ikon mata
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: _buildInputDecoration(
                    'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: const Color(0xFF949494),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF949494),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height:
                        screenHeight * 0.05), // Jarak dinamis sebelum tombol

                // Tombol Create dengan gradasi dan rounded corners
                InkWell(
                  borderRadius: BorderRadius.circular(
                      30.0), // Tambahkan borderRadius untuk efek ripple
                  splashColor: Colors.white
                      .withOpacity(0.3), // Warna ripple lebih terang
                  highlightColor: Colors.transparent, // Menghilangkan highlight
                  onTap: _submitForm,
                  onTapDown: (_) {
                    // Ubah warna tombol saat ditekan
                    setState(() {
                      _isButtonPressed = true;
                    });
                  },
                  onTapUp: (_) {
                    // Kembalikan warna tombol setelah dilepaskan
                    setState(() {
                      _isButtonPressed = false;
                    });
                  },
                  onTapCancel: () {
                    // Kembalikan warna tombol jika jari keluar dari tombol tanpa melepaskannya
                    setState(() {
                      _isButtonPressed = false;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: _isButtonPressed
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFB24146),
                                Color(0xFFD58E2F)
                              ], // Warna yang lebih gelap saat ditekan
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : const LinearGradient(
                              colors: [
                                Color(0xFFF24146),
                                Color(0xFFF58E2F)
                              ], // Warna default
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius:
                          BorderRadius.circular(30.0), // Rounded corners
                    ),
                    child: const Center(
                      child: Text(
                        "Create", // Ubah teks menjadi "Create"
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white, // Warna teks putih
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05), // Jarak setelah tombol

                // Tombol Login
                TextButton(
                  onPressed: () {
                    // Aksi ketika tombol Login ditekan, bisa diarahkan ke halaman login
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFF15900), // Warna teks oranye
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
