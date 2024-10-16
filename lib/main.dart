import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up.dart';
import 'screens/get_started.dart';
import 'screens/home_screen.dart'; // Import HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spend Diary',
      debugShowCheckedModeBanner: false,
      initialRoute: '/get_started', // Set halaman awal menjadi Get Started
      routes: {
        '/get_started': (context) => const GetStarted(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpView(),
        '/home': (context) =>
            const HomeScreen(), // Tambahkan rute untuk HomeScreen
      },
    );
  }
}
