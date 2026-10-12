import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';

Widget _app(Widget child, {SampathColors colors = SampathColors.light}) =>
    MaterialApp(
      theme: ThemeData(extensions: [colors]),
      home: Center(child: child),
    );

// `68px bg` mask vector (20:373), copied from Figma.
const _figma68 =
    'M 25.294938351918624 0 L 42.70220825452669 0 C 45.9660713612657 0 '
    '48.751688748506545 1.1536847459082678 51.05905860297744 3.461054600379161 '
    'L 64.53608946748565 16.938089454085304 C 66.84345932195654 '
    '19.245459308556196 67.99714660644531 22.03107524517961 67.99714660644531 '
    '25.294938351918624 L 67.99714660644531 42.70220825452669 C '
    '67.99714660644531 45.9660713612657 66.84345932195654 48.751688748506545 '
    '64.53608946748565 51.05905860297744 L 51.05905860297744 64.53608946748565 '
    'C 48.751688748506545 66.84345932195654 45.9660713612657 67.99714660644531 '
    '42.70220825452669 67.99714660644531 L 25.294938351918624 '
    '67.99714660644531 C 22.03107524517961 67.99714660644531 '
    '19.245459308556196 66.84345932195654 16.938089454085304 64.53608946748565 '
    'L 3.461054600379161 51.05905860297744 C 1.1536847459082678 '
    '48.751688748506545 0 45.9660713612657 0 42.70220825452669 L 0 '
    '25.294938351918624 C 0 22.03107524517961 1.1536847459082678 '
    '19.245459308556196 3.461054600379161 16.938089454085304 L '
    '16.938089454085304 3.461054600379161 C 19.245459308556196 '
    '1.1536847459082678 22.03107524517961 0 25.294938351918624 0 Z';

// Minimal parser for Figma's absolute M/L/C/Z path data.
Path _parse(String d) {
  final t = d.split(' ');
  final path = Path();
  var i = 0;
  double n() => double.parse(t[i++]);
  while (i < t.length) {
    switch (t[i++]) {
      case 'M':
        path.moveTo(n(), n());
      case 'L':
        path.lineTo(n(), n());
      case 'C':
        path.cubicTo(n(), n(), n(), n(), n(), n());
      case 'Z':
        path.close();
    }
  }
  return path;
}

SampathIcon _icon(WidgetTester t) => t.widget(find.byType(SampathIcon));

Color? _bg(WidgetTester t) =>
    ((t.widget(find.byType(DecoratedBox)) as DecoratedBox).decoration
            as ShapeDecoration)
        .color;

ShapeBorder _shape(WidgetTester t) =>
    ((t.widget(find.byType(DecoratedBox)) as DecoratedBox).decoration
            as ShapeDecoration)
        .shape;

void main() {
  group('octagon', () {
    test('matches the Figma 68px bg mask vector', () {
      const size = 67.99714660644531;
      final figma = _parse(_figma68);
      final ours = const SampathOctagonBorder().getOuterPath(
        Offset.zero & const Size.square(size),
      );
      expect(ours.getBounds(), figma.getBounds());
      // Every point on a 0.25 px grid is inside both or outside both.
      var checked = 0;
      for (var x = -0.5; x <= size + 0.5; x += 0.25) {
        for (var y = -0.5; y <= size + 0.5; y += 0.25) {
          final p = Offset(x, y);
          expect(ours.contains(p), figma.contains(p), reason: '$p');
          checked++;
        }
      }
      expect(checked, greaterThan(70000));
    });

    test('corners are cut', () {
      final path = const SampathOctagonBorder().getOuterPath(
        Offset.zero & const Size.square(42),
      );
      expect(path.contains(const Offset(1, 1)), isFalse);
      expect(path.contains(const Offset(21, 0.5)), isTrue);
    });
  });

  group('SampathIconBadge', () {
    const c = SampathColors.light;
    final expected = {
      SampathIconBadgeState.primary: (c.bgIcons, SampathIconColor.brand),
      SampathIconBadgeState.secondary: (c.bgIcons, SampathIconColor.secondary),
      SampathIconBadgeState.disabled: (
        c.bgDisabled,
        SampathIconColor.disabledOnBg,
      ),
      SampathIconBadgeState.success: (c.fgSuccess, SampathIconColor.inverse),
      SampathIconBadgeState.error: (c.fgError, SampathIconColor.inverse),
      SampathIconBadgeState.info: (c.fgInfo, SampathIconColor.inverse),
      SampathIconBadgeState.warning: (c.fgWarning, SampathIconColor.inverse),
    };
    for (final MapEntry(key: state, value: (bg, fg)) in expected.entries) {
      testWidgets('${state.name}: background and icon color', (t) async {
        await t.pumpWidget(
          _app(SampathIconBadge.medium(SampathIcons.lock, state: state)),
        );
        expect(_bg(t), bg);
        expect(_icon(t).color, fg);
        expect(_shape(t), isA<SampathOctagonBorder>());
      });
    }

    testWidgets('medium is 42 with a 24px icon', (t) async {
      await t.pumpWidget(
        _app(const SampathIconBadge.medium(SampathIcons.lock)),
      );
      expect(t.getSize(find.byType(SampathIconBadge)), const Size.square(42));
      expect(_icon(t).size, SampathIconSize.s24);
      expect(
        t.getCenter(find.byType(SampathIcon)),
        t.getCenter(find.byType(SampathIconBadge)),
      );
    });

    testWidgets('large is 68 with a 36px icon', (t) async {
      await t.pumpWidget(_app(const SampathIconBadge.large(SampathIcons.lock)));
      expect(t.getSize(find.byType(SampathIconBadge)), const Size.square(68));
      expect(_icon(t).size, SampathIconSize.s36);
    });

    testWidgets('follows Dark mode', (t) async {
      await t.pumpWidget(
        _app(
          const SampathIconBadge.medium(SampathIcons.lock),
          colors: SampathColors.dark,
        ),
      );
      expect(_bg(t), SampathColors.dark.bgIcons);
    });

    testWidgets('takes brand icons', (t) async {
      await t.pumpWidget(
        _app(const SampathIconBadge.large(SampathIcons.assistant)),
      );
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });

  group('SampathSquareIcon', () {
    const sizes = {
      SampathSquareIconSize.xSmall: (
        24.0,
        SampathRadius.s,
        SampathIconSize.s16,
      ),
      SampathSquareIconSize.small: (42.0, SampathRadius.m, SampathIconSize.s20),
      SampathSquareIconSize.medium: (
        50.0,
        SampathRadius.m,
        SampathIconSize.s24,
      ),
      SampathSquareIconSize.large: (64.0, SampathRadius.l, SampathIconSize.s36),
    };
    for (final MapEntry(key: size, value: (box, radius, icon))
        in sizes.entries) {
      testWidgets('${size.name}: $box box, radius $radius, centered', (
        t,
      ) async {
        await t.pumpWidget(
          _app(SampathSquareIcon(SampathIcons.lock, size: size)),
        );
        expect(t.getSize(find.byType(SampathSquareIcon)), Size.square(box));
        expect(
          _shape(t),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        );
        expect(_icon(t).size, icon);
        expect(
          t.getCenter(find.byType(SampathIcon)),
          t.getCenter(find.byType(SampathSquareIcon)),
        );
      });
    }

    const c = SampathColors.light;
    final states = {
      SampathSquareIconState.brand: (c.bgIcons, SampathIconColor.brand),
      SampathSquareIconState.success: (c.bgSuccess, SampathIconColor.success),
      SampathSquareIconState.error: (c.bgError, SampathIconColor.error),
      SampathSquareIconState.warning: (c.bgWarning, SampathIconColor.warning),
      SampathSquareIconState.info: (c.bgInfo, SampathIconColor.info),
    };
    for (final MapEntry(key: state, value: (bg, fg)) in states.entries) {
      testWidgets('${state.name}: background and icon color', (t) async {
        await t.pumpWidget(
          _app(SampathSquareIcon(SampathIcons.lock, state: state)),
        );
        expect(_bg(t), bg);
        expect(_icon(t).color, fg);
      });
    }
  });

  group('SampathCircleIcon', () {
    for (final (size, box, icon) in [
      (SampathCircleIconSize.small, 36.0, SampathIconSize.s16),
      (SampathCircleIconSize.large, 56.0, SampathIconSize.s24),
    ]) {
      testWidgets('${size.name}: $box circle, bg-secondary, fg-brand', (
        t,
      ) async {
        await t.pumpWidget(
          _app(SampathCircleIcon(SampathIcons.lock, size: size)),
        );
        expect(t.getSize(find.byType(SampathCircleIcon)), Size.square(box));
        expect(_shape(t), const CircleBorder());
        expect(_bg(t), SampathColors.light.bgSecondary);
        expect(_icon(t).size, icon);
        expect(_icon(t).color, SampathIconColor.brand);
      });
    }

    testWidgets('no shadow', (t) async {
      await t.pumpWidget(_app(const SampathCircleIcon(SampathIcons.lock)));
      final d =
          (t.widget(find.byType(DecoratedBox)) as DecoratedBox).decoration
              as ShapeDecoration;
      expect(d.shadows, isNull);
    });
  });

  testWidgets('semantic label reaches the icon', (t) async {
    final handle = t.ensureSemantics();
    await t.pumpWidget(
      _app(
        const SampathSquareIcon(SampathIcons.wallet, semanticLabel: 'Wallet'),
      ),
    );
    expect(find.bySemanticsLabel('Wallet'), findsOneWidget);
    handle.dispose();
  });
}
