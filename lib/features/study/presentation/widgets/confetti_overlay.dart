import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/gamification_providers.dart';

class ConfettiOverlay extends ConsumerStatefulWidget {
  final Widget child;

  const ConfettiOverlay({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends ConsumerState<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_ConfettiParticle> _particles = [];
  final Random _random = Random();
  int _lastTriggerValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..addListener(() {
        setState(() {
          _updateParticles();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spawnConfetti() {
    _particles.clear();
    final Size size = MediaQuery.of(context).size;

    // Spawn 120 particles from top center/left/right spread
    for (int i = 0; i < 120; i++) {
      _particles.add(
        _ConfettiParticle(
          x: _random.nextDouble() * size.width,
          y: -10.0 - (_random.nextDouble() * 100.0),
          vx: (_random.nextDouble() * 8.0) - 4.0, // horizontal speed
          vy: (_random.nextDouble() * 10.0) + 4.0, // vertical gravity speed
          color: _getRandomColor(),
          size: (_random.nextDouble() * 8.0) + 6.0,
          rotation: _random.nextDouble() * pi * 2,
          rotationSpeed: (_random.nextDouble() * 0.1) - 0.05,
        ),
      );
    }
    _controller.forward(from: 0.0);
  }

  void _updateParticles() {
    for (var p in _particles) {
      p.x += p.vx;
      p.y += p.vy;
      p.rotation += p.rotationSpeed;
      // Add slight horizontal drift/wind
      p.vx += (sin(p.y / 30) * 0.08);
    }
  }

  Color _getRandomColor() {
    final colors = [
      const Color(0xFFF472B6), // Sakura pink
      const Color(0xFF10B981), // Emerald
      const Color(0xFF3B82F6), // Blue
      const Color(0xFFF59E0B), // Gold
      const Color(0xFF8B5CF6), // Purple
      const Color(0xFFEF4444), // Coral Red
    ];
    return colors[_random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Listen for confetti trigger increments
    ref.listen<int>(confettiTriggerProvider, (previous, current) {
      if (current > _lastTriggerValue) {
        _lastTriggerValue = current;
        _spawnConfetti();
      }
    });

    return Stack(
      children: [
        widget.child,
        if (_controller.isAnimating)
          IgnorePointer(
            child: CustomPaint(
              size: Size.infinite,
              painter: _ConfettiPainter(_particles),
            ),
          ),
      ],
    );
  }
}

class _ConfettiParticle {
  double x;
  double y;
  double vx;
  double vy;
  final Color color;
  final double size;
  double rotation;
  final double rotationSpeed;

  _ConfettiParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;

  _ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var p in particles) {
      if (p.y < 0 || p.y > size.height + 20) continue;
      if (p.x < -20 || p.x > size.width + 20) continue;

      paint.color = p.color;

      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);

      // Draw a rotating rectangle/square confetti particle
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6),
          const Radius.circular(2),
        ),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
