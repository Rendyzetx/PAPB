import 'package:flutter/material.dart';
import 'package:spend_diary/screens/login_screen.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _topSlideAnimation;
  late Animation<Offset> _bottomSlideAnimation;

  bool _isButtonPressed = false; // Menyimpan status tombol apakah ditekan

  @override
  void initState() {
    super.initState();

    // Inisialisasi AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Inisialisasi animasi untuk komponen atas (bergerak dari atas ke bawah)
    _topSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Mulai dari di atas layar
      end: Offset.zero, // Berakhir di posisinya semula
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Inisialisasi animasi untuk komponen bawah (bergerak dari bawah ke atas)
    _bottomSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Mulai dari di bawah layar
      end: Offset.zero, // Berakhir di posisinya semula
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Mulai animasi ketika widget diinisialisasi
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLoginScreen() {
    Navigator.of(context).push(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration:
          const Duration(milliseconds: 800), // Tambahkan durasi lebih lama
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide dari kanan ke kiri
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),

              // Komponen atas (logo dan teks) dengan animasi Slide dari atas ke bawah
              SlideTransition(
                position: _topSlideAnimation,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/spend.png',
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.2,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    const Text(
                      "SpendDiary",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 199, 93, 93),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Gambar ilustrasi (tetap tidak dianimasikan)
              Image.asset(
                'assets/images/manage.png',
                height: screenHeight * 0.4,
                fit: BoxFit.contain,
              ),

              SizedBox(height: screenHeight * 0.02),

              // Teks deskripsi (dengan animasi Slide dari atas ke bawah)
              SlideTransition(
                position: _topSlideAnimation,
                child: const Text(
                  "Track your expenses, manage your finances effortlessly.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 199, 93, 93),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Komponen bawah (tombol) dengan animasi Slide dari bawah ke atas
              SlideTransition(
                position: _bottomSlideAnimation,
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                      30.0), // Tambahkan borderRadius untuk efek ripple
                  splashColor: Colors.white
                      .withOpacity(0.3), // Warna ripple lebih terang
                  highlightColor: Colors.transparent, // Menghilangkan highlight
                  onTap:
                      _navigateToLoginScreen, // Navigasi dengan transisi slide
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
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
