// Smoke test: every Foundations page builds in Light and Dark without
// layout errors (overflow, unbounded sizes).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:sampath_widgetbook/components/avatar_use_cases.dart';
import 'package:sampath_widgetbook/components/icon_use_cases.dart';
import 'package:sampath_widgetbook/foundations/colors_page.dart';
import 'package:sampath_widgetbook/foundations/gradients_page.dart';
import 'package:sampath_widgetbook/foundations/layout_page.dart';
import 'package:sampath_widgetbook/foundations/radius_page.dart';
import 'package:sampath_widgetbook/foundations/shadows_page.dart';
import 'package:sampath_widgetbook/foundations/spacing_page.dart';
import 'package:sampath_widgetbook/foundations/typography_page.dart';
import 'package:sampath_widgetbook/theme.dart';

void main() {
  final pages = <String, Widget>{
    'Colors': const ColorsPage(),
    'Typography': TypographyPage(),
    for (final l in SampleLanguage.values)
      'Typography ${l.label}': TypographyPage(sample: l.phrase),
    'Spacing': const SpacingPage(),
    'Radius': const RadiusPage(),
    'Layout': const LayoutPage(),
    'Shadows': const ShadowsPage(),
    'Gradients': const GradientsPage(),
    'Icon grid': const IconSizeStateGrid(icon: SampathIcons.lock),
    'Icon registry': const IconRegistry(),
    'Brand avatar grid': const AvatarGrid(shape: AvatarShape.brand),
    'Avatar grid': const AvatarGrid(shape: AvatarShape.circle),
  };
  final themes = {'Light': CatalogueTheme.light, 'Dark': CatalogueTheme.dark};

  for (final page in pages.entries) {
    for (final theme in themes.entries) {
      testWidgets('${page.key} · ${theme.key}', (tester) async {
        tester.view.physicalSize = const Size(390, 844); // phone width
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          MaterialApp(
            theme: theme.value,
            home: Scaffold(body: page.value),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    }
  }
}
