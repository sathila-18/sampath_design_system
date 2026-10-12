import 'package:flutter/widgets.dart';

/// The rounded brand octagon of `46px bg` and `68px bg` (DESIGN.md §9.1).
///
/// The path is the Figma mask vector (`20:313`, 41.998 × 41.998) normalised
/// to a unit square and scaled to the box, so it's exact at every size. The
/// `68px bg` mask (`20:373`) is the same shape scaled.
class SampathOctagonBorder extends OutlinedBorder {
  const SampathOctagonBorder({super.side});

  // Figma mask vector size; every coordinate below is divided by it.
  static const double _figmaSize = 41.99823760986328;

  // Edge offsets used by the Figma path (in Figma units).
  static const double _a = 0.7125699901198124;
  static const double _b = 2.137710194351835;
  static const double _c = 10.461761133405629;
  static const double _d = 11.886901337637651;
  static const double _e = 13.607428827905055;
  static const double _f = 15.623344276185033;

  static Path _unitPath(Rect rect) {
    final sx = rect.width / _figmaSize;
    final sy = rect.height / _figmaSize;
    const s = _figmaSize;
    final path = Path();
    // Figma coordinates → rect coordinates.
    double x(double v) => rect.left + v * sx;
    double y(double v) => rect.top + v * sy;
    void line(double x1, double y1) => path.lineTo(x(x1), y(y1));
    void curve(List<double> v) =>
        path.cubicTo(x(v[0]), y(v[1]), x(v[2]), y(v[3]), x(v[4]), y(v[5]));

    // Clockwise from the top edge, exactly as the Figma vector.
    path.moveTo(x(_f), y(0));
    line(s - _f, 0);
    curve([s - _e, 0, s - _d, _a, s - _c, _b]);
    line(s - _b, _c);
    curve([s - _a, _d, s, _e, s, _f]);
    line(s, s - _f);
    curve([s, s - _e, s - _a, s - _d, s - _b, s - _c]);
    line(s - _c, s - _b);
    curve([s - _d, s - _a, s - _e, s, s - _f, s]);
    line(_f, s);
    curve([_e, s, _d, s - _a, _c, s - _b]);
    line(_b, s - _c);
    curve([_a, s - _d, 0, s - _e, 0, s - _f]);
    line(0, _f);
    curve([0, _e, _a, _d, _b, _c]);
    line(_c, _b);
    curve([_d, _a, _e, 0, _f, 0]);
    return path..close();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _unitPath(rect);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      _unitPath(rect.deflate(side.strokeInset));

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.strokeInset);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;
    canvas.drawPath(
      _unitPath(rect.inflate(side.strokeOffset / 2)),
      side.toPaint(),
    );
  }

  @override
  SampathOctagonBorder copyWith({BorderSide? side}) =>
      SampathOctagonBorder(side: side ?? this.side);

  @override
  ShapeBorder scale(double t) => SampathOctagonBorder(side: side.scale(t));

  @override
  bool operator ==(Object other) =>
      other is SampathOctagonBorder && other.side == side;

  @override
  int get hashCode => side.hashCode;
}
