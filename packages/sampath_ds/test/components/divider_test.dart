import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';

Widget _app(Widget child, {SampathColors colors = SampathColors.light}) =>
    MaterialApp(
      theme: ThemeData(extensions: [colors]),
      home: Center(child: SizedBox(width: 343, child: child)),
    );

Color? _fill(WidgetTester t) =>
    t.widget<ColoredBox>(find.byType(ColoredBox).last).color;

void main() {
  group('SampathDivider', () {
    for (final (type, height) in [
      (SampathDividerType.divider, 1.0),
      (SampathDividerType.section, 8.0),
    ]) {
      testWidgets('${type.name}: full width, $height high', (t) async {
        await t.pumpWidget(_app(SampathDivider(type: type)));
        expect(t.getSize(find.byType(SampathDivider)), Size(343, height));
        expect(_fill(t), SampathColors.light.borderDefault);
      });
    }

    testWidgets('follows Dark mode', (t) async {
      await t.pumpWidget(
        _app(const SampathDivider(), colors: SampathColors.dark),
      );
      expect(_fill(t), SampathColors.dark.borderDefault);
    });
  });

  group('SampathDividerDash', () {
    testWidgets('full width, 1 high', (t) async {
      await t.pumpWidget(_app(const SampathDividerDash()));
      expect(t.getSize(find.byType(SampathDividerDash)), const Size(343, 1));
    });

    testWidgets('paints 1.5 / 1.5 dashes, round caps, border-default', (
      t,
    ) async {
      await t.pumpWidget(
        _app(const SampathDividerDash(), colors: SampathColors.dark),
      );
      final box = find.descendant(
        of: find.byType(SampathDividerDash),
        matching: find.byType(CustomPaint),
      );
      final dash = SampathColors.dark.borderDefault;
      expect(
        box,
        paints
          ..line(
            p1: const Offset(0, 0.5),
            p2: const Offset(1.5, 0.5),
            color: dash,
            strokeWidth: 1,
          )
          ..line(p1: const Offset(3, 0.5), p2: const Offset(4.5, 0.5)),
      );
      final painter = t.widget<CustomPaint>(box).painter!;
      final canvas = _CountingCanvas();
      painter.paint(canvas, const Size(343, 1));
      // 343 / 3 → 115 dashes, the last cut at the edge.
      expect(canvas.lines, 115);
      expect(canvas.caps, {StrokeCap.round});
      expect(canvas.maxX, 343);
    });
  });

  testWidgets('decorative: no semantics', (t) async {
    final handle = t.ensureSemantics();
    await t.pumpWidget(
      _app(const Column(children: [SampathDivider(), SampathDividerDash()])),
    );
    expect(find.bySemanticsLabel(RegExp('.')), findsNothing);
    handle.dispose();
  });
}

class _CountingCanvas extends Fake implements Canvas {
  int lines = 0;
  double maxX = 0;
  final caps = <StrokeCap>{};

  @override
  void drawLine(Offset p1, Offset p2, Paint paint) {
    lines++;
    caps.add(paint.strokeCap);
    if (p2.dx > maxX) maxX = p2.dx;
  }
}
