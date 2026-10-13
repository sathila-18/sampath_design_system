import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components/avatar_use_cases.dart';
import 'components/divider_use_cases.dart';
import 'components/icon_container_use_cases.dart';
import 'components/icon_use_cases.dart';
import 'foundations/colors_page.dart';
import 'foundations/gradients_page.dart';
import 'foundations/layout_page.dart';
import 'foundations/radius_page.dart';
import 'foundations/shadows_page.dart';
import 'foundations/spacing_page.dart';
import 'foundations/typography_page.dart';
import 'theme.dart';

void main() => runApp(const SampathWidgetbook());

class SampathWidgetbook extends StatelessWidget {
  const SampathWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: CatalogueTheme.light),
            WidgetbookTheme(name: 'Dark', data: CatalogueTheme.dark),
          ],
        ),
      ],
      directories: [
        WidgetbookFolder(
          name: 'Foundations',
          isInitiallyExpanded: true,
          children: [
            _page('Colors', const ColorsPage()),
            WidgetbookComponent(
              name: 'Typography',
              useCases: [
                WidgetbookUseCase(
                  name: 'All',
                  builder: (context) {
                    final language = context.knobs.object.dropdown(
                      label: 'Language',
                      options: SampleLanguage.values,
                      labelBuilder: (l) => l.label,
                    );
                    final custom = context.knobs.string(
                      label: 'Custom text',
                      description: 'Overrides the language phrase when set',
                    );
                    return TypographyPage(
                      sample: custom.trim().isEmpty ? language.phrase : custom,
                    );
                  },
                ),
              ],
            ),
            _page('Spacing', const SpacingPage()),
            _page('Radius', const RadiusPage()),
            _page('Layout', const LayoutPage()),
            _page('Shadows', const ShadowsPage()),
            _page('Gradients', const GradientsPage()),
          ],
        ),
        WidgetbookFolder(
          name: 'Components',
          isInitiallyExpanded: true,
          children: [
            iconComponent(),
            ...iconContainerComponents(),
            ...dividerComponents(),
            ...avatarComponents(),
          ],
        ),
      ],
    );
  }

  static WidgetbookComponent _page(String name, Widget page) {
    return WidgetbookComponent(
      name: name,
      useCases: [WidgetbookUseCase(name: 'All', builder: (_) => page)],
    );
  }
}
