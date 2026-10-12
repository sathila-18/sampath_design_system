import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:widgetbook/widgetbook.dart';

import '../foundations/foundation_page.dart';

/// Use cases for `SampathIcon` (DESIGN.md §9.1).
WidgetbookComponent iconComponent() => WidgetbookComponent(
  name: 'Icon',
  useCases: [
    for (final size in SampathIconSize.values)
      WidgetbookUseCase(
        name: '${size.dimension.toInt()}px',
        builder: (context) {
          final type = iconTypeKnob(context);
          final icon = iconKnob(context, type);
          return _SingleIcon(
            icon: icon,
            size: size,
            // Brand icons keep their own colors, so no Color knob for them.
            color: type == IconType.utility
                ? _colorKnob(context)
                : SampathIconColor.primary,
          );
        },
      ),
    WidgetbookUseCase(
      name: 'Sizes × states',
      builder: (context) => IconSizeStateGrid(icon: _gridIconKnob(context)),
    ),
    WidgetbookUseCase(
      name: 'Registry',
      builder: (context) => const IconRegistry(),
    ),
  ],
);

// The Figma `State` variants; other fg-* colors are for component specs.
const _states = [
  SampathIconColor.primary,
  SampathIconColor.secondary,
  SampathIconColor.disabled,
  SampathIconColor.success,
  SampathIconColor.error,
  SampathIconColor.info,
  SampathIconColor.warning,
];

enum IconType {
  utility('Utility (Iconoir)', SampathIcons.utility, SampathIcons.lock),
  asset('Brand & partner', SampathIcons.assets, SampathIcons.assistant);

  const IconType(this.label, this.icons, this.initial);

  final String label;
  final List<SampathIconData> icons;
  final SampathIconData initial;

  List<SampathIconData> get sorted =>
      [...icons]..sort((a, b) => a.figmaName.compareTo(b.figmaName));
}

IconType iconTypeKnob(BuildContext context) =>
    context.knobs.object.dropdown<IconType>(
      label: 'Icon type',
      options: IconType.values,
      labelBuilder: (t) => t.label,
    );

// When the type changes, an Icon value from the other list falls back to
// the type's initial icon.
SampathIconData iconKnob(BuildContext context, IconType type) =>
    context.knobs.object.dropdown<SampathIconData>(
      label: 'Icon',
      options: type.sorted,
      initialOption: type.initial,
      labelBuilder: (i) => i.figmaName,
    );

// Utility only: brand icons ignore color, so a states grid says nothing.
SampathIconData _gridIconKnob(BuildContext context) =>
    iconKnob(context, IconType.utility);

SampathIconColor _colorKnob(BuildContext context) =>
    context.knobs.object.dropdown<SampathIconColor>(
      label: 'Color',
      description: 'First seven are the Figma State variants',
      options: SampathIconColor.values,
      labelBuilder: (c) => c.name,
    );

class _SingleIcon extends StatelessWidget {
  const _SingleIcon({
    required this.icon,
    required this.size,
    required this.color,
  });

  final SampathIconData icon;
  final SampathIconSize size;
  final SampathIconColor color;

  @override
  Widget build(BuildContext context) {
    final isAsset = icon is SampathAssetIcon;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SampathIcon(icon, size: size, color: color),
          const SizedBox(height: SampathSpacing.l),
          TokenLabel(
            icon.figmaName,
            isAsset
                ? '${size.dimension.toInt()}px · own colors (not recolored)'
                : '${size.dimension.toInt()}px · ${color.name}',
          ),
        ],
      ),
    );
  }
}

class IconSizeStateGrid extends StatelessWidget {
  const IconSizeStateGrid({super.key, required this.icon});

  final SampathIconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final caption = SampathTextStyles.captionLarge.copyWith(
      color: colors.textSecondary,
    );
    // Column width fits the widest label ("disabled", "warning").
    const cell = SampathSpacing.x9l;
    return FoundationPage(
      title: 'Icon · sizes × states',
      source:
          'Figma Icon sizes page · ${icon.figmaName} · '
          'switch Light / Dark with the Theme addon',
      sections: [
        FoundationSection(
          title: 'Grid',
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(cell),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      const SizedBox.shrink(),
                      for (final s in _states) Text(s.name, style: caption),
                    ],
                  ),
                  for (final size in SampathIconSize.values)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: SampathSpacing.m,
                          ),
                          child: Text(
                            '${size.dimension.toInt()}px',
                            style: caption,
                          ),
                        ),
                        for (final s in _states)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SampathIcon(icon, size: size, color: s),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class IconRegistry extends StatelessWidget {
  const IconRegistry({super.key});

  @override
  Widget build(BuildContext context) {
    Widget tile(SampathIconData icon) => SizedBox(
      width: SampathSpacing.x11l,
      child: Row(
        children: [
          SampathIcon(icon),
          const SizedBox(width: SampathLayout.iconText),
          Expanded(
            child: Text(
              icon.figmaName,
              style: SampathTextStyles.captionLarge.copyWith(
                color: context.colors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
    return FoundationPage(
      title: 'Icon registry',
      source:
          'SampathIcons · only icons the Figma component file uses · '
          '${SampathIcons.utility.length} utility, '
          '${SampathIcons.assets.length} brand / partner',
      sections: [
        FoundationSection(
          title: 'Utility (Iconoir, fg-primary)',
          wrap: true,
          children: [for (final i in SampathIcons.utility) tile(i)],
        ),
        FoundationSection(
          title: 'Brand and partner (own colors)',
          wrap: true,
          children: [for (final i in SampathIcons.assets) tile(i)],
        ),
      ],
    );
  }
}

/// Icon type + Icon knobs, for components with a swappable icon.
SampathIconData pickIconKnobs(BuildContext context) =>
    iconKnob(context, iconTypeKnob(context));
