import 'package:flutter/widgets.dart';

import '../../tokens/sampath_colors.dart';

/// A full-width dashed `border-default` line: `Divider dash` (DESIGN.md §9.2).
///
/// Drawn like the Figma stroke: 1 px wide, dash 1.5 / gap 1.5, round caps
/// (so each dash shows about 2.5 px with a 0.5 px gap).
///
/// Takes the width of its parent. Decorative: not read by screen readers.
class SampathDividerDash extends StatelessWidget {
  const SampathDividerDash({super.key});

  /// Figma stroke weight, which is also the line's height.
  static const double thickness = 1;

  /// Figma `dashPattern` [1.5, 1.5].
  static const double dash = 1.5;
  static const double gap = 1.5;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: thickness,
    child: CustomPaint(painter: _DashPainter(context.colors.borderDefault)),
  );
}

class _DashPainter extends CustomPainter {
  const _DashPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = SampathDividerDash.thickness
      ..strokeCap = StrokeCap.round;
    final y = size.height / 2;
    // Like the Figma line (x 0.5 → width − 0.5): inset by half the stroke so
    // the round caps stay inside the box.
    const cap = SampathDividerDash.thickness / 2;
    final last = size.width - cap;
    const step = SampathDividerDash.dash + SampathDividerDash.gap;
    for (var x = cap; x < last; x += step) {
      final end = (x + SampathDividerDash.dash).clamp(cap, last);
      canvas.drawLine(Offset(x, y), Offset(end, y), paint);
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) => old.color != color;
}
