import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';

Widget _app(Widget child, {SampathColors colors = SampathColors.light}) =>
    MaterialApp(
      theme: ThemeData(extensions: [colors]),
      home: Center(child: child),
    );

void main() {
  group('registry', () {
    test('48 Iconoir icons from Figma, names unique', () {
      final names = SampathIcons.utility.map((i) => i.figmaName).toList();
      expect(names, hasLength(48));
      expect(names.toSet(), hasLength(48));
      expect(names, contains('xmark-solid')); // drawn with XmarkCircleSolid
    });

    test('brand icons and partner logo', () {
      expect(SampathIcons.assets.map((i) => (i.figmaName, i.kind)), [
        ('assistant', SampathAssetIconKind.brand),
        ('insights', SampathAssetIconKind.brand),
        ('transaction', SampathAssetIconKind.brand),
        ('transfer', SampathAssetIconKind.brand),
        ('paypal', SampathAssetIconKind.partner),
      ]);
    });

    testWidgets('every utility icon builds', (tester) async {
      for (final icon in SampathIcons.utility) {
        await tester.pumpWidget(_app(SampathIcon(icon)));
        expect(tester.takeException(), isNull, reason: icon.figmaName);
      }
    });
  });

  test('sizes are the five from Figma', () {
    expect(SampathIconSize.values.map((s) => s.dimension), [
      16,
      20,
      24,
      36,
      48,
    ]);
  });

  test('Figma State variants map to fg-* tokens', () {
    const c = SampathColors.light;
    expect(SampathIconColor.primary.resolve(c), c.fgPrimary);
    expect(SampathIconColor.secondary.resolve(c), c.fgSecondary);
    expect(SampathIconColor.disabled.resolve(c), c.fgDisabled);
    expect(SampathIconColor.success.resolve(c), c.fgSuccess);
    expect(SampathIconColor.error.resolve(c), c.fgError);
    expect(SampathIconColor.info.resolve(c), c.fgInfo);
    expect(SampathIconColor.warning.resolve(c), c.fgWarning);
    // Light values as bound in Figma (Icon sizes page).
    expect(c.fgPrimary, const Color(0xFF141D27));
    expect(c.fgDisabled, const Color(0xFFB6B9BC));
  });

  for (final size in SampathIconSize.values) {
    testWidgets('renders at ${size.name}', (tester) async {
      await tester.pumpWidget(_app(SampathIcon(SampathIcons.lock, size: size)));
      expect(
        tester.getSize(find.byType(SampathIcon)),
        Size.square(size.dimension),
      );
    });
  }

  testWidgets('utility icon color follows the theme mode', (tester) async {
    ColorFilter? colorOf() =>
        tester.widget<SvgPicture>(find.byType(SvgPicture)).colorFilter;
    await tester.pumpWidget(_app(const SampathIcon(SampathIcons.lock)));
    final light = colorOf();
    await tester.pumpWidget(
      _app(const SampathIcon(SampathIcons.lock), colors: SampathColors.dark),
    );
    await tester.pumpAndSettle(); // MaterialApp animates theme changes
    expect(colorOf(), isNot(light));
    expect(
      colorOf(),
      const ColorFilter.mode(Color(0xFFFDFBFA), BlendMode.srcIn),
    );
  });

  testWidgets('brand icons ignore color', (tester) async {
    await tester.pumpWidget(
      _app(
        const SampathIcon(
          SampathIcons.assistant,
          color: SampathIconColor.error,
        ),
      ),
    );
    final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(svg.colorFilter, isNull);
  });

  testWidgets('semantics: label when given, hidden otherwise', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(const SampathIcon(SampathIcons.lock, semanticLabel: 'Locked')),
    );
    expect(find.bySemanticsLabel('Locked'), findsOneWidget);
    await tester.pumpWidget(_app(const SampathIcon(SampathIcons.lock)));
    expect(find.bySemanticsLabel('Locked'), findsNothing);
    handle.dispose();
  });
}
