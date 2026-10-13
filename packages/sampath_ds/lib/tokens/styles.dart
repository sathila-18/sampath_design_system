// Hand-written from DESIGN.md §4 (Figma styles, not variables).
// Not generated: Figma styles aren't in the token export. When a Figma style
// changes, update DESIGN.md §4 and this file together.
//
// Values read from Foundation (Z4B0Qjw4IfoGY5UHmgpbnp) on 12 Oct 2026.
// Motion (§5) is deferred and intentionally not here.

import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import 'sampath_palette.dart';

/// Border widths. DESIGN.md §4.5. Code-only: Figma has no variable for
/// stroke weight, so these are the weights its components use.
abstract final class SampathBorderWidth {
  /// 1 px: avatar outlines (`Brand avatar`, `Avatar`) and the Profile
  /// image button ring.
  static const double thin = 1;
}

/// Minimum touch target. DESIGN.md §2 rule 7 and §4.6. Code-only: an
/// accessibility rule, not a Figma variable.
abstract final class SampathTouchTarget {
  /// 44 × 44, even when the visible control is smaller.
  static const double min = 44;
}

/// Effect styles (`Shadow/*`). DESIGN.md §4.3.
///
/// Figma's shadow **blur** maps to [BoxShadow.blurRadius] directly. Shadows
/// are the same in Light and Dark.
abstract final class SampathShadows {
  /// `Shadow/Resting_cards` · cards at rest.
  static const List<BoxShadow> restingCards = [
    BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 3),
  ];

  /// `Shadow/Panel_sheets` · panels and bottom sheets.
  static const List<BoxShadow> panelSheets = [
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 2), blurRadius: 10),
  ];

  /// `Shadow/Floating_nav-search` · floating bottom nav, search.
  ///
  /// The Figma style also has a background blur; pair these shadows with a
  /// `BackdropFilter(filter: SampathShadows.floatingNavSearchBlur)`.
  static const List<BoxShadow> floatingNavSearch = [
    BoxShadow(color: Color(0x14140F0A), offset: Offset(0, 2), blurRadius: 8),
    BoxShadow(color: Color(0x29140F0A), offset: Offset(0, 8), blurRadius: 30),
  ];

  /// Background blur of `Shadow/Floating_nav-search` (Figma blur 20 ≈ σ 10).
  static ImageFilter get floatingNavSearchBlur =>
      ImageFilter.blur(sigmaX: 10, sigmaY: 10);

  /// `Shadow/Back` drop shadow · back button circle.
  ///
  /// The style also has an inner shadow, [backInner]. Paint it with
  /// [SampathInnerShadowPainter].
  static const List<BoxShadow> back = [
    BoxShadow(color: Color(0x0F0B1B2B), offset: Offset(0, 2), blurRadius: 10),
  ];

  /// `Shadow/Back` inner shadow: a 1 px white highlight along the top edge.
  static const List<SampathInnerShadow> backInner = [
    SampathInnerShadow(color: Color(0x66FFFFFF), offset: Offset(0, 1)),
  ];

  /// `Shadow/Sticky` · sticky bottom elements. Negative y: falls upward.
  static const List<BoxShadow> sticky = [
    BoxShadow(color: Color(0x14221F1F), offset: Offset(0, -2), blurRadius: 16),
  ];
}

/// An inner shadow, which [BoxShadow] can't express.
@immutable
final class SampathInnerShadow {
  const SampathInnerShadow({
    required this.color,
    this.offset = Offset.zero,
    this.blurRadius = 0,
  });

  final Color color;
  final Offset offset;

  /// Figma blur, same convention as [BoxShadow.blurRadius].
  final double blurRadius;
}

/// Paints [shadows] inside [shape]. Use as `CustomPaint.foregroundPainter`
/// over the widget that has the shape.
class SampathInnerShadowPainter extends CustomPainter {
  const SampathInnerShadowPainter({required this.shape, required this.shadows});

  final ShapeBorder shape;
  final List<SampathInnerShadow> shadows;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final path = shape.getOuterPath(rect);
    canvas
      ..save()
      ..clipPath(path);
    for (final shadow in shadows) {
      // Everything outside the shape, shifted by the offset. Clipped to the
      // shape, this leaves the sliver the offset uncovers.
      final outside = Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(rect.inflate(shadow.blurRadius * 2 + shadow.offset.distance))
        ..addPath(path, shadow.offset);
      final paint = Paint()..color = shadow.color;
      if (shadow.blurRadius > 0) {
        paint.maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          Shadow.convertRadiusToSigma(shadow.blurRadius),
        );
      }
      canvas.drawPath(outside, paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(SampathInnerShadowPainter old) =>
      old.shape != shape || old.shadows != shadows;
}

/// Gradient color styles. DESIGN.md §4.2. Same in Light and Dark.
///
/// Each gradient uses Figma's own `gradientTransform` (via
/// [SampathFigmaGradientTransform]) so the direction matches Figma at any
/// aspect ratio, not just on squares.
abstract final class SampathGradients {
  /// `Luxury purple` · Violet-500 → Violet-400.
  static const LinearGradient luxuryPurple = LinearGradient(
    colors: [SampathPalette.violet500, SampathPalette.violet400],
    transform: _diagonal,
  );

  /// `Vermilion` · `#f26722` → `#dc5e1f`.
  ///
  /// ⚠️ Off the brand orange scale, so the stops are raw hex as recorded in
  /// DESIGN.md §4.2. Design will update it (§10 #2).
  static const LinearGradient vermilion = LinearGradient(
    colors: [Color(0xFFF26722), Color(0xFFDC5E1F)],
    transform: _diagonal,
  );

  /// `Assistant` · Orange-50 → White.
  static const LinearGradient assistant = LinearGradient(
    colors: [SampathPalette.orange50, SampathPalette.white],
    transform: SampathFigmaGradientTransform(
      1.2801,
      0.3041,
      0, //
      -1.7932,
      1.511,
      0.5,
    ),
  );

  // Shared by `Luxury purple` and `Vermilion` (identical in Figma).
  static const _diagonal = SampathFigmaGradientTransform(
    0.9817,
    0.3619,
    -0.3436, //
    -2.4627,
    1.237,
    1.362,
  );

  /// Every gradient by its Figma name (for catalogues).
  static const Map<String, LinearGradient> byFigmaName = {
    'Luxury purple': luxuryPurple,
    'Vermilion': vermilion,
    'Assistant': assistant,
  };
}

/// Applies a Figma `gradientTransform` to a Flutter [LinearGradient].
///
/// Figma stores linear gradients as a 2×3 matrix `[[a, b, c], [d, e, f]]`
/// that maps the node's unit box to gradient space, where the gradient runs
/// along x from 0 to 1. Use with the gradient's default
/// `begin: Alignment.centerLeft, end: Alignment.centerRight`.
@immutable
final class SampathFigmaGradientTransform extends GradientTransform {
  const SampathFigmaGradientTransform(
    this.a,
    this.b,
    this.c,
    this.d,
    this.e,
    this.f,
  );

  final double a, b, c, d, e, f;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    final w = bounds.width, h = bounds.height;
    final det = a * e - b * d;
    if (w == 0 || h == 0 || det == 0) return Matrix4.identity();

    // Gradient space → unit box (inverse of the Figma matrix).
    final ia = e / det, ib = -b / det, id = -d / det, ie = a / det;
    final ic = -(ia * c + ib * f), ifx = -(id * c + ie * f);

    // The shader draws centerLeft → centerRight of `bounds`, i.e. it works in
    // "gradient space scaled to bounds". Map that to pixels:
    // pixels = toPixels · inverse(figma) · toUnit.
    final toPixels = Matrix4.identity()
      ..setEntry(0, 0, w)
      ..setEntry(1, 1, h)
      ..setEntry(0, 3, bounds.left)
      ..setEntry(1, 3, bounds.top);
    final inverse = Matrix4.identity()
      ..setEntry(0, 0, ia)
      ..setEntry(0, 1, ib)
      ..setEntry(0, 3, ic)
      ..setEntry(1, 0, id)
      ..setEntry(1, 1, ie)
      ..setEntry(1, 3, ifx);
    final toUnit = Matrix4.identity()
      ..setEntry(0, 0, 1 / w)
      ..setEntry(1, 1, 1 / h)
      ..setEntry(0, 3, -bounds.left / w)
      ..setEntry(1, 3, -bounds.top / h);
    return toPixels.multiplied(inverse).multiplied(toUnit);
  }

  @override
  bool operator ==(Object other) =>
      other is SampathFigmaGradientTransform &&
      other.a == a &&
      other.b == b &&
      other.c == c &&
      other.d == d &&
      other.e == e &&
      other.f == f;

  @override
  int get hashCode => Object.hash(a, b, c, d, e, f);
}
