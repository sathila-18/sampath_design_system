// Checks the generated tokens against the resolved values in DESIGN.md §3,
// with a focus on the export quirks the generator handles (§3.8).
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:sampath_ds/tokens/sampath_palette.dart';

void main() {
  group('semantic colors resolve per mode', () {
    test('aliases follow Light and Dark separately', () {
      expect(SampathColors.light.bgPrimary, const Color(0xFFF7F3EF));
      expect(SampathColors.dark.bgPrimary, const Color(0xFF141416));
      expect(SampathColors.light.bgActive, const Color(0xFFFDE7D6));
      expect(SampathColors.dark.bgActive, const Color(0xFF66330E));
    });

    test('alpha colors apply alpha to the referenced color', () {
      expect(SampathColors.light.alphaSm, const Color(0x29141416));
      expect(SampathColors.light.alphaNav, const Color(0xBFFFFFFF));
      expect(SampathColors.dark.alphaNav, const Color(0x0FFFFFFF));
      expect(SampathColors.light.alphaBorder, const Color(0x14141416));
      expect(SampathColors.dark.alphaBorder, const Color(0x05141416));
      expect(SampathColors.light.alphaShade, const Color(0x00F7F3EF));
      expect(SampathColors.dark.alphaShade, const Color(0x00141416));
    });

    test('lerp blends between modes', () {
      final mid = SampathColors.light.lerp(SampathColors.dark, 1);
      expect(mid.textPrimary, SampathColors.dark.textPrimary);
    });
  });

  test('palette aliases point at primitives', () {
    expect(SampathPalette.primary1_500, SampathPalette.orange500);
    expect(SampathPalette.primary1_900, SampathPalette.orange900);
    expect(SampathPalette.text500, const Color(0xFF141D27));
  });

  test('spacing, radius and layout', () {
    expect(SampathSpacing.xl, 16);
    expect(SampathSpacing.x2l, 20);
    expect(SampathSpacing.x4l, 32);
    expect(SampathRadius.m, 12);
    expect(SampathRadius.full, 999999);
    expect(SampathLayout.screenMargin, 16);
    expect(SampathLayout.headerToContent, 16);
    expect(SampathLayout.sectionGap, 24);
    expect(SampathLayout.sectionGapLarge, 32);
    expect(SampathLayout.buttonGap, 12);
  });

  group('typography', () {
    test('weights from px dimensions, line height as a ratio', () {
      const style = SampathTextStyles.displayLargeH1;
      expect(style.fontWeight, FontWeight.w800);
      expect(style.fontSize, 36);
      expect(style.fontSize! * style.height!, closeTo(46.8, 0.001));
      expect(style.fontFamily, 'packages/sampath_ds/Hanken Grotesk');
      expect(style.fontFamilyFallback, [
        'packages/sampath_ds/Noto Sans Sinhala',
        'packages/sampath_ds/Noto Sans Tamil',
      ]);
    });

    test('every style matches DESIGN.md §3.4', () {
      // (style, weight, size, line height). A list, not a map: some styles
      // are equal (e.g. titleMedium and labelLarge) and would collapse as keys.
      final expected = <(TextStyle, FontWeight, double, double)>[
        (SampathTextStyles.displayLargeH1, FontWeight.w800, 36, 46.8),
        (SampathTextStyles.displayMediumH2, FontWeight.w800, 32, 41.6),
        (SampathTextStyles.displaySmallH3, FontWeight.w800, 28, 39.2),
        (SampathTextStyles.headlineLargeH4, FontWeight.w800, 24, 33.6),
        (SampathTextStyles.headlineMediumH5, FontWeight.w700, 20, 28),
        (SampathTextStyles.headlineSmallH6, FontWeight.w700, 16, 24),
        (SampathTextStyles.bodyLarge, FontWeight.w400, 16, 24),
        (SampathTextStyles.bodyMedium, FontWeight.w400, 14, 21),
        (SampathTextStyles.bodySmall, FontWeight.w400, 12, 18),
        (SampathTextStyles.titleXLarge, FontWeight.w600, 32, 41.6),
        (SampathTextStyles.titleLarge, FontWeight.w600, 18, 25.2),
        (SampathTextStyles.titleMedium, FontWeight.w600, 16, 24),
        (SampathTextStyles.titleSmall, FontWeight.w600, 14, 21),
        (SampathTextStyles.labelLarge, FontWeight.w600, 16, 24),
        (SampathTextStyles.labelMedium, FontWeight.w600, 14, 21),
        (SampathTextStyles.labelSmall, FontWeight.w600, 12, 18),
        (SampathTextStyles.captionLarge, FontWeight.w500, 12, 18),
        (SampathTextStyles.captionMedium, FontWeight.w500, 11, 16.5),
        (SampathTextStyles.captionSmall, FontWeight.w600, 10, 15),
        (SampathTextStyles.buttonXLarge, FontWeight.w700, 18, 24),
        (SampathTextStyles.buttonLarge, FontWeight.w700, 16, 24),
        (SampathTextStyles.buttonMedium, FontWeight.w700, 14, 24),
        (SampathTextStyles.buttonSmall, FontWeight.w700, 12, 24),
      ];
      for (final (style, weight, size, lineHeight) in expected) {
        expect(style.fontWeight, weight);
        expect(style.fontSize, size);
        expect(style.fontSize! * style.height!, closeTo(lineHeight, 0.01));
      }
    });
  });
}
