import 'package:flutter/material.dart';
import 'package:spend_diary/utils/loading_animation.dart'; // Import file animasi

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoginPressed = false;

  void _submitLoginForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoginPressed = true; // Ganti status tombol
      });

      Future.delayed(const Duration(seconds: 2), () {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Login successful'),
        //   ),
        // );

        setState(() {
          _isLoginPressed = false;
        });

        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  InputDecoration _buildInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      fillColor: const Color(0xFF494A59),
      filled: true,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      hintText: labelText,
      hintStyle: const TextStyle(color: Colors.white54),
      suffixIcon: Icon(icon, color: const Color(0xFF949494)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color(0xFF949494)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color(0xFF949494)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.white),
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: Image.asset(
                    'assets/images/spend.png',
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                const Text(
                  "Login Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Image.asset(
                  'assets/images/expense.png',
                  height: screenHeight * 0.2,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.03),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Email', Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Password', Icons.lock),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                _isLoginPressed
                    ? const LoadingAnimation() // Pakai animasi dari file loading_animation.dart
                    : InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        splashColor: Colors.white.withOpacity(0.3),
                        highlightColor: Colors.transparent,
                        onTap: _submitLoginForm,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFF15900), Color(0xFFF58E2F)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: screenHeight * 0.02),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    "Create new account",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Color(0xFFF15900),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
