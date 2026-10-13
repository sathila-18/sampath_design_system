import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';

Widget _app(Widget child, {SampathColors colors = SampathColors.light}) =>
    MaterialApp(
      theme: ThemeData(extensions: [colors]),
      home: Center(child: child),
    );

// Brand avatar vectors, copied from Figma (stroke-centred, so offset 0.5).
const _figmaBrand = {
  SampathAvatarSize.xSmall:
      'M9.428 0.5H15.572C16.724 0.5 17.7072 0.9072 18.5216 1.7216L23.2784 6.4784C24.0928 7.2928 24.5 8.276 24.5 9.428V15.572C24.5 16.724 24.0928 17.7072 23.2784 18.5216L18.5216 23.2784C17.7072 24.0928 16.724 24.5 15.572 24.5H9.428C8.276 24.5 7.2928 24.0928 6.4784 23.2784L1.7216 18.5216C0.9072 17.7072 0.5 16.724 0.5 15.572V9.428C0.5 8.276 0.9072 7.2928 1.7216 6.4784L6.4784 1.7216C7.2928 0.9072 8.276 0.5 9.428 0.5Z',
  SampathAvatarSize.small:
      'M12.404 0.5H20.596C22.132 0.5 23.4429 1.04293 24.5288 2.1288L30.8712 8.4712C31.9571 9.55707 32.5 10.868 32.5 12.404V20.596C32.5 22.132 31.9571 23.4429 30.8712 24.5288L24.5288 30.8712C23.4429 31.9571 22.132 32.5 20.596 32.5H12.404C10.868 32.5 9.55707 31.9571 8.4712 30.8712L2.1288 24.5288C1.04293 23.4429 0.5 22.132 0.5 20.596V12.404C0.5 10.868 1.04293 9.55707 2.1288 8.4712L8.4712 2.1288C9.55707 1.04293 10.868 0.5 12.404 0.5Z',
  SampathAvatarSize.medium:
      'M15.38 0.5H25.62C27.54 0.5 29.1787 1.17867 30.536 2.536L38.464 10.464C39.8213 11.8213 40.5 13.46 40.5 15.38V25.62C40.5 27.54 39.8213 29.1787 38.464 30.536L30.536 38.464C29.1787 39.8213 27.54 40.5 25.62 40.5H15.38C13.46 40.5 11.8213 39.8213 10.464 38.464L2.536 30.536C1.17867 29.1787 0.5 27.54 0.5 25.62V15.38C0.5 13.46 1.17867 11.8213 2.536 10.464L10.464 2.536C11.8213 1.17867 13.46 0.5 15.38 0.5Z',
  SampathAvatarSize.large:
      'M18.356 0.5H30.644C32.948 0.5 34.9144 1.3144 36.5432 2.9432L46.0568 12.4568C47.6856 14.0856 48.5 16.052 48.5 18.356V30.644C48.5 32.948 47.6856 34.9144 46.0568 36.5432L36.5432 46.0568C34.9144 47.6856 32.948 48.5 30.644 48.5H18.356C16.052 48.5 14.0856 47.6856 12.4568 46.0568L2.9432 36.5432C1.3144 34.9144 0.5 32.948 0.5 30.644V18.356C0.5 16.052 1.3144 14.0856 2.9432 12.4568L12.4568 2.9432C14.0856 1.3144 16.052 0.5 18.356 0.5Z',
  SampathAvatarSize.xLarge:
      'M21.332 0.5H35.668C38.356 0.5 40.6501 1.45013 42.5504 3.3504L53.6496 14.4496C55.5499 16.3499 56.5 18.644 56.5 21.332V35.668C56.5 38.356 55.5499 40.6501 53.6496 42.5504L42.5504 53.6496C40.6501 55.5499 38.356 56.5 35.668 56.5H21.332C18.644 56.5 16.3499 55.5499 14.4496 53.6496L3.3504 42.5504C1.45013 40.6501 0.5 38.356 0.5 35.668V21.332C0.5 18.644 1.45013 16.3499 3.3504 14.4496L14.4496 3.3504C16.3499 1.45013 18.644 0.5 21.332 0.5Z',
  SampathAvatarSize.xxLarge:
      'M24.308 0.5H40.692C43.764 0.5 46.3859 1.58587 48.5576 3.7576L61.2424 16.4424C63.4141 18.6141 64.5 21.236 64.5 24.308V40.692C64.5 43.764 63.4141 46.3859 61.2424 48.5576L48.5576 61.2424C46.3859 63.4141 43.764 64.5 40.692 64.5H24.308C21.236 64.5 18.6141 63.4141 16.4424 61.2424L3.7576 48.5576C1.58587 46.3859 0.5 43.764 0.5 40.692V24.308C0.5 21.236 1.58587 18.6141 3.7576 16.4424L16.4424 3.7576C18.6141 1.58587 21.236 0.5 24.308 0.5Z',
  SampathAvatarSize.xxxLarge:
      'M37.7 0.5H63.3C68.1 0.5 72.1967 2.19667 75.59 5.59L95.41 25.41C98.8033 28.8033 100.5 32.9 100.5 37.7V63.3C100.5 68.1 98.8033 72.1967 95.41 75.59L75.59 95.41C72.1967 98.8033 68.1 100.5 63.3 100.5H37.7C32.9 100.5 28.8033 98.8033 25.41 95.41L5.59 75.59C2.19667 72.1967 0.5 68.1 0.5 63.3V37.7C0.5 32.9 2.19667 28.8033 5.59 25.41L25.41 5.59C28.8033 2.19667 32.9 0.5 37.7 0.5Z',
};

// Minimal parser for Figma's absolute M/H/V/L/C/Z path data.
Path _parse(String d, {double shift = 0}) {
  final t = RegExp(
    r'[MHVLCZ]|-?[\d.]+',
  ).allMatches(d).map((m) => m[0]!).toList();
  final path = Path();
  var i = 0;
  var x = 0.0, y = 0.0;
  double n() => double.parse(t[i++]) - shift;
  while (i < t.length) {
    switch (t[i++]) {
      case 'M':
        path.moveTo(x = n(), y = n());
      case 'L':
        path.lineTo(x = n(), y = n());
      case 'H':
        path.lineTo(x = n(), y);
      case 'V':
        path.lineTo(x, y = n());
      case 'C':
        final c = [n(), n(), n(), n()];
        path.cubicTo(c[0], c[1], c[2], c[3], x = n(), y = n());
      case 'Z':
        path.close();
    }
  }
  return path;
}

ShapeDecoration _outline(WidgetTester t) =>
    (t.widget(find.byType(DecoratedBox).first) as DecoratedBox).decoration
        as ShapeDecoration;

/// An image that never finishes loading.
class _PendingImage extends ImageProvider<_PendingImage> {
  const _PendingImage();

  @override
  Future<_PendingImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(_PendingImage key, ImageDecoderCallback d) =>
      OneFrameImageStreamCompleter(Completer<ImageInfo>().future);
}

/// An image that fails to load.
class _BrokenImage extends ImageProvider<_BrokenImage> {
  const _BrokenImage();

  @override
  Future<_BrokenImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(_BrokenImage key, ImageDecoderCallback d) =>
      OneFrameImageStreamCompleter(Future.error(StateError('broken')));
}

/// A loaded 1 × 1 image.
class _LoadedImage extends ImageProvider<_LoadedImage> {
  const _LoadedImage(this.image);

  final ui.Image image;

  @override
  Future<_LoadedImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(_LoadedImage key, ImageDecoderCallback d) =>
      OneFrameImageStreamCompleter(
        SynchronousFuture(ImageInfo(image: image.clone())),
      );
}

typedef _Make =
    Widget Function({
      ImageProvider? image,
      String? initials,
      SampathAvatarSize size,
    });

Widget _brand({
  ImageProvider? image,
  String? initials,
  SampathAvatarSize size = SampathAvatarSize.medium,
}) => SampathBrandAvatar(image: image, initials: initials, size: size);

Widget _circle({
  ImageProvider? image,
  String? initials,
  SampathAvatarSize size = SampathAvatarSize.medium,
}) => SampathAvatar(image: image, initials: initials, size: size);

final _avatar = find.byWidgetPredicate(
  (w) => w is SampathBrandAvatar || w is SampathAvatar,
);

void main() {
  test('sizes, icon sizes and text styles match Figma', () {
    final expected = {
      SampathAvatarSize.xSmall: (
        24,
        SampathIconSize.s16,
        SampathTextStyles.labelSmall,
      ),
      SampathAvatarSize.small: (
        32,
        SampathIconSize.s20,
        SampathTextStyles.labelSmall,
      ),
      SampathAvatarSize.medium: (
        40,
        SampathIconSize.s24,
        SampathTextStyles.labelLarge,
      ),
      SampathAvatarSize.large: (
        48,
        SampathIconSize.s36,
        SampathTextStyles.titleLarge,
      ),
      SampathAvatarSize.xLarge: (
        56,
        SampathIconSize.s36,
        SampathTextStyles.headlineLargeH4,
      ),
      SampathAvatarSize.xxLarge: (
        64,
        SampathIconSize.s48,
        SampathTextStyles.displaySmallH3,
      ),
      SampathAvatarSize.xxxLarge: (
        100,
        SampathIconSize.s48,
        SampathTextStyles.displayLargeH1,
      ),
    };
    expect(expected.keys, SampathAvatarSize.values);
    for (final MapEntry(key: s, value: (dim, icon, text)) in expected.entries) {
      expect(s.dimension, dim, reason: s.name);
      expect(s.iconSize, icon, reason: s.name);
      expect(s.textStyle, text, reason: s.name);
    }
  });

  group('brand octagon', () {
    for (final MapEntry(key: size, value: d) in _figmaBrand.entries) {
      test('matches the Figma ${size.name} vector', () {
        final dim = size.dimension;
        // The Figma path is drawn 0.5 in from its 0.5 px stroke margin.
        final figma = _parse(d, shift: 0.5);
        final ours = const SampathOctagonBorder().getOuterPath(
          Offset.zero & Size.square(dim),
        );
        // Grid offset from whole/half pixels, where Figma's 4-decimal
        // rounding could land exactly on the edge.
        var checked = 0;
        for (var x = -0.43; x <= dim + 0.5; x += 0.25) {
          for (var y = -0.43; y <= dim + 0.5; y += 0.25) {
            final p = Offset(x, y);
            expect(ours.contains(p), figma.contains(p), reason: '$p');
            checked++;
          }
        }
        expect(checked, greaterThan(dim * dim * 15));
      });
    }
  });

  for (final (name, make, shape, align) in <(String, _Make, Type, double)>[
    (
      'SampathBrandAvatar',
      _brand,
      SampathOctagonBorder,
      BorderSide.strokeAlignCenter,
    ),
    ('SampathAvatar', _circle, CircleBorder, BorderSide.strokeAlignInside),
  ]) {
    group(name, () {
      for (final size in SampathAvatarSize.values) {
        testWidgets('${size.name}: box, icon and text', (t) async {
          await t.pumpWidget(_app(make(size: size)));
          expect(t.getSize(_avatar), Size.square(size.dimension));
          final icon = t.widget<SampathIcon>(find.byType(SampathIcon));
          expect(icon.icon, SampathIcons.user);
          expect(icon.size, size.iconSize);
          expect(icon.color, SampathIconColor.secondary);
          expect(t.getCenter(find.byType(SampathIcon)), t.getCenter(_avatar));

          await t.pumpWidget(_app(make(size: size, initials: 'SD')));
          final text = t.widget<Text>(find.text('SD'));
          expect(text.style!.fontSize, size.textStyle.fontSize);
          expect(text.style!.fontWeight, size.textStyle.fontWeight);
          expect(text.style!.color, SampathColors.light.textSecondary);
        });
      }

      testWidgets('outline: border-subtle, 1 px, Figma alignment', (t) async {
        await t.pumpWidget(_app(make()));
        final outline = _outline(t).shape as OutlinedBorder;
        expect(outline.runtimeType, shape);
        expect(outline.side.color, SampathColors.light.borderSubtle);
        expect(outline.side.width, SampathAvatarSize.borderWidth);
        expect(outline.side.strokeAlign, align);
      });

      testWidgets('Icon type: bg-secondary behind the user icon', (t) async {
        await t.pumpWidget(_app(make()));
        expect(
          t.widget<ColoredBox>(find.byType(ColoredBox).last).color,
          SampathColors.light.bgSecondary,
        );
      });

      testWidgets('follows Dark mode', (t) async {
        const d = SampathColors.dark;
        await t.pumpWidget(_app(make(initials: 'SD'), colors: d));
        expect(
          t.widget<ColoredBox>(find.byType(ColoredBox).last).color,
          d.bgSecondary,
        );
        expect(t.widget<Text>(find.text('SD')).style!.color, d.textSecondary);
        expect(
          (_outline(t).shape as OutlinedBorder).side.color,
          d.borderSubtle,
        );
      });

      testWidgets('initials are shown exactly as given', (t) async {
        await t.pumpWidget(_app(make(initials: 'sD')));
        expect(find.text('sD'), findsOneWidget);
      });

      testWidgets('empty initials fall back to the icon', (t) async {
        await t.pumpWidget(_app(make(initials: '')));
        expect(find.byType(SampathIcon), findsOneWidget);
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('Image type: the loaded photo, no fallback', (t) async {
        final img = await t.runAsync(
          () => createTestImage(width: 1, height: 1),
        );
        await t.pumpWidget(
          _app(make(image: _LoadedImage(img!), initials: 'SD')),
        );
        await t.pump();
        expect(find.byType(RawImage), findsOneWidget);
        expect(t.widget<RawImage>(find.byType(RawImage)).image, isNotNull);
        expect(t.widget<RawImage>(find.byType(RawImage)).fit, BoxFit.cover);
        expect(find.text('SD'), findsNothing);
        expect(find.byType(SampathIcon), findsNothing);
      });

      testWidgets('loading photo shows the initials, else the icon', (t) async {
        await t.pumpWidget(
          _app(make(image: const _PendingImage(), initials: 'SD')),
        );
        expect(find.text('SD'), findsOneWidget);
        await t.pumpWidget(_app(make(image: const _PendingImage())));
        expect(find.byType(SampathIcon), findsOneWidget);
      });

      testWidgets('broken photo shows the initials, else the icon', (t) async {
        await t.pumpWidget(
          _app(make(image: const _BrokenImage(), initials: 'SD')),
        );
        await t.pump();
        expect(find.text('SD'), findsOneWidget);
        await t.pumpWidget(_app(make(image: const _BrokenImage())));
        await t.pump();
        expect(find.byType(SampathIcon), findsOneWidget);
      });
    });
  }

  testWidgets('semantics: label when given, else decorative', (t) async {
    final handle = t.ensureSemantics();
    await t.pumpWidget(
      _app(
        const Column(
          children: [
            SampathBrandAvatar(
              initials: 'SD',
              semanticLabel: 'Sathila de Silva',
            ),
            SampathAvatar(initials: 'AB'),
          ],
        ),
      ),
    );
    expect(find.bySemanticsLabel('Sathila de Silva'), findsOneWidget);
    expect(find.bySemanticsLabel('SD'), findsNothing);
    expect(find.bySemanticsLabel('AB'), findsNothing);
    handle.dispose();
  });
}
