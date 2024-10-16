import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Putar animasi terus menerus
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox(
            height: 50,
            width: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Lingkaran pertama
                Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: CustomPaint(
                    painter: CirclePainter(color: Colors.orange),
                    size: const Size(50, 50),
                  ),
                ),
                // Lingkaran kedua
                Transform.rotate(
                  angle: -_controller.value * 2.0 * math.pi,
                  child: CustomPaint(
                    painter: CirclePainter(color: Colors.red),
                    size: const Size(50, 50),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Painter untuk menggambar dua garis lingkaran yang tidak saling terhubung
class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path()
      ..addArc(Rect.fromLTWH(0, 0, size.width, size.height), 0,
          math.pi / 1.5) // Garis lingkaran pertama
      ..addArc(Rect.fromLTWH(0, 0, size.width, size.height), math.pi,
          math.pi / 1.5); // Garis lingkaran kedua

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
