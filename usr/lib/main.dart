import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MuseumApp());
}

class MuseumApp extends StatelessWidget {
  const MuseumApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Museum Clock Scene',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MuseumScene(),
      },
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
      ),
    );
  }
}

class MuseumScene extends StatefulWidget {
  const MuseumScene({Key? key}) : super(key: key);

  @override
  State<MuseumScene> createState() => _MuseumSceneState();
}

class _MuseumSceneState extends State<MuseumScene>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Smooth ease-in-out zoom effect
    _scaleAnimation = Tween<double>(begin: 1.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    // Start the camera movement after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The alignment controls the focal point of the scale. 
    // Alignment(0.0, -0.3) is exactly where we will place the center of the clock.
    const focalPoint = Alignment(0.0, -0.3);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Tap to reset and replay the camera movement
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment: focalPoint,
              transform: Matrix4.identity()
                ..scale(_scaleAnimation.value, _scaleAnimation.value),
              child: const MuseumRoom(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        elevation: 0,
        onPressed: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: const Icon(Icons.videocam, color: Colors.white),
      ),
    );
  }
}

class MuseumRoom extends StatelessWidget {
  const MuseumRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Wall
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E2129), Color(0xFF2B323D)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        
        // Wainscoting (Bottom wood panel)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1A1311),
              border: Border(
                top: BorderSide(color: Color(0xFF3E2723), width: 8),
              ),
            ),
            child: Stack(
              children: [
                // Floor perspective lines simulation
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.2,
                    child: CustomPaint(
                      painter: FloorPainter(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        // Left Painting
        Align(
          alignment: const Alignment(-0.8, -0.1),
          child: PaintingWidget(
            width: 120,
            height: 160,
            gradient: const LinearGradient(
              colors: [Colors.orange, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Right Painting
        Align(
          alignment: const Alignment(0.8, -0.1),
          child: PaintingWidget(
            width: 120,
            height: 160,
            gradient: const LinearGradient(
              colors: [Colors.teal, Colors.lightBlueAccent],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),

        // Left Pedestal & Sculpture
        Align(
          alignment: const Alignment(-0.7, 0.7),
          child: PedestalWidget(),
        ),

        // Right Pedestal & Sculpture
        Align(
          alignment: const Alignment(0.7, 0.7),
          child: PedestalWidget(),
        ),

        // Center Wall Clock
        const Align(
          // Matches the focalPoint of the Transform
          alignment: Alignment(0.0, -0.3),
          child: AnimatedClock(),
        ),
        
        // Ceiling lights (Soft glow)
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -2.5),
                radius: 3.0,
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class AnimatedClock extends StatefulWidget {
  const AnimatedClock({Key? key}) : super(key: key);

  @override
  State<AnimatedClock> createState() => _AnimatedClockState();
}

class _AnimatedClockState extends State<AnimatedClock>
    with SingleTickerProviderStateMixin {
  late AnimationController _clockController;

  @override
  void initState() {
    super.initState();
    _clockController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  @override
  void dispose() {
    _clockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFF5F5DC), // Beige clock face
        border: Border.all(color: const Color(0xFFD4AF37), width: 6), // Gold trim
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _clockController,
        builder: (context, child) {
          return CustomPaint(
            painter: ClockPainter(timeProgress: _clockController.value),
          );
        },
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final double timeProgress;

  ClockPainter({required this.timeProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw markings
    final markPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
      
    for (int i = 0; i < 12; i++) {
      final angle = i * 30 * (pi / 180);
      final outerX = center.dx + cos(angle) * (radius - 4);
      final outerY = center.dy + sin(angle) * (radius - 4);
      final innerX = center.dx + cos(angle) * (radius - 12);
      final innerY = center.dy + sin(angle) * (radius - 12);
      canvas.drawLine(Offset(innerX, innerY), Offset(outerX, outerY), markPaint);
    }

    // Minute Hand (Moves fast based on 60 sec controller)
    final minAngle = timeProgress * 2 * pi * 12 - (pi / 2);
    final minPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    final minX = center.dx + cos(minAngle) * (radius * 0.7);
    final minY = center.dy + sin(minAngle) * (radius * 0.7);
    canvas.drawLine(center, Offset(minX, minY), minPaint);

    // Hour Hand (Moves slower)
    final hourAngle = timeProgress * 2 * pi - (pi / 2);
    final hourPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final hourX = center.dx + cos(hourAngle) * (radius * 0.45);
    final hourY = center.dy + sin(hourAngle) * (radius * 0.45);
    canvas.drawLine(center, Offset(hourX, hourY), hourPaint);

    // Center dot
    final dotPaint = Paint()..color = const Color(0xFFD4AF37);
    canvas.drawCircle(center, 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) {
    return oldDelegate.timeProgress != timeProgress;
  }
}

class PaintingWidget extends StatelessWidget {
  final double width;
  final double height;
  final Gradient gradient;

  const PaintingWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF111111), // Inner frame
        border: Border.all(color: const Color(0xFFD4AF37), width: 6), // Gold frame
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(gradient: gradient),
      ),
    );
  }
}

class PedestalWidget extends StatelessWidget {
  const PedestalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sculpture (Abstract glass/gem)
        Container(
          width: 30,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 2,
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Base
        Container(
          width: 50,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            border: Border.all(color: Colors.grey.shade400, width: 2),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 10,
                offset: const Offset(5, 5),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FloorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // Draw perspective lines coming from a vanishing point above the floor
    final vanishingPoint = Offset(size.width / 2, -size.height * 2);

    for (int i = -5; i <= 5; i++) {
      final startX = size.width / 2 + (i * size.width / 4);
      canvas.drawLine(vanishingPoint, Offset(startX, size.height), paint);
    }
    
    // Draw horizontal depth lines
    for (int i = 1; i < 6; i++) {
      final y = size.height * (i / 5) * (i / 5);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
