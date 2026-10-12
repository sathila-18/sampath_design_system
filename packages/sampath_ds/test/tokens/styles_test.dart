// Checks styles.dart against the Figma styles recorded in DESIGN.md §4.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';

/// Gradient position t (0 at the start handle, 1 at the end handle) of
/// [pixel] for [gradient] painted in [bounds].
double _t(LinearGradient gradient, Rect bounds, Offset pixel) {
  final m = gradient.transform!.transform(bounds)!;
  final shader = MatrixUtils.transformPoint(Matrix4.inverted(m), pixel);
  return (shader.dx - bounds.left) / bounds.width;
}

void main() {
  group('gradients follow the Figma handles', () {
    // Handle positions in the unit box, from inverting the Figma matrices.
    const purpleStart = Offset(0.35, 0), purpleEnd = Offset(0.9375, 1.1696);
    const assistantStart = Offset.zero, assistantEnd = Offset(0.6094, 0.7232);

    for (final bounds in const [
      Rect.fromLTWH(0, 0, 100, 100),
      Rect.fromLTWH(20, 40, 343, 120), // wide card, offset on screen
      Rect.fromLTWH(0, 0, 80, 300), // tall
    ]) {
      Offset at(Offset unit) => Offset(
        bounds.left + unit.dx * bounds.width,
        bounds.top + unit.dy * bounds.height,
      );
      test('$bounds', () {
        for (final g in [
          SampathGradients.luxuryPurple,
          SampathGradients.vermilion,
        ]) {
          expect(_t(g, bounds, at(purpleStart)), closeTo(0, 0.001));
          expect(_t(g, bounds, at(purpleEnd)), closeTo(1, 0.001));
        }
        const a = SampathGradients.assistant;
        expect(_t(a, bounds, at(assistantStart)), closeTo(0, 0.001));
        expect(_t(a, bounds, at(assistantEnd)), closeTo(1, 0.001));
      });
    }
  });

  test('gradient stops', () {
    expect(SampathGradients.luxuryPurple.colors, [
      const Color(0xFF5E2FE0),
      const Color(0xFF7E59E6),
    ]);
    expect(SampathGradients.vermilion.colors, [
      const Color(0xFFF26722),
      const Color(0xFFDC5E1F),
    ]);
    expect(SampathGradients.assistant.colors, [
      const Color(0xFFFDE7D6),
      const Color(0xFFFFFFFF),
    ]);
  });

  test('shadows match the Figma effect styles', () {
    expect(SampathShadows.restingCards, const [
      BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 3),
    ]);
    expect(SampathShadows.floatingNavSearch, hasLength(2));
    expect(SampathShadows.sticky.single.offset, const Offset(0, -2));
    expect(SampathShadows.backInner.single.color, const Color(0x66FFFFFF));
  });
}
