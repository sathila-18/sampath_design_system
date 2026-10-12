import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

import 'foundation_page.dart';

/// Every semantic color in the current mode, grouped as in Figma.
class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  static const _groups = {
    'Background': 'bg-',
    'Text': 'text-',
    'Border': 'border-',
    'Foreground': 'fg-',
    'Alpha': 'Alpha-',
  };

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors.byFigmaName;
    return FoundationPage(
      title: 'Colors',
      source:
          'Color collection · ${tokens.length} semantic tokens · '
          'switch Light / Dark with the Theme addon',
      sections: [
        for (final MapEntry(key: group, value: prefix) in _groups.entries)
          FoundationSection(
            title: group,
            wrap: true,
            children: [
              for (final MapEntry(:key, :value) in tokens.entries)
                if (key.startsWith(prefix)) _Swatch(name: key, color: value),
            ],
          ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: SampathSpacing.x11l + SampathSpacing.x5l,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: SampathSpacing.x8l,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SampathRadius.m),
              border: Border.all(color: colors.borderDefault),
            ),
            // Checkerboard shows through the Alpha tokens.
            child: CustomPaint(
              painter: _CheckerPainter(colors.borderSubtle),
              child: ColoredBox(color: color),
            ),
          ),
          const SizedBox(height: SampathSpacing.s),
          TokenLabel(name, _hex(color)),
        ],
      ),
    );
  }

  static String _hex(Color c) {
    String h(double v) =>
        (v * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
    final rgb = '#${h(c.r)}${h(c.g)}${h(c.b)}';
    return c.a == 1 ? rgb : '$rgb · ${(c.a * 100).round()}%';
  }
}

class _CheckerPainter extends CustomPainter {
  const _CheckerPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const cell = SampathSpacing.m;
    final paint = Paint()..color = color;
    for (var y = 0.0; y < size.height; y += cell) {
      for (var x = 0.0; x < size.width; x += cell) {
        if (((x + y) / cell).round().isEven) {
          canvas.drawRect(Rect.fromLTWH(x, y, cell, cell), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_CheckerPainter old) => old.color != color;
}
